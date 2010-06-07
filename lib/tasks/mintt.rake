require 'ffaker'

MALE_FEMALE = %w[male female]
YES_NO = %w[yes no]
TRUE_FALSE = [true, false]

namespace :db do
  
  desc "Load all development fixtures."
  task :populate => ['populate:empty_all_tables', 'populate:mail_templates', 'populate:messages', 'populate:users']
  
  namespace :populate do
    
    desc "Empty all the tables"
    task :empty_all_tables => :environment do
      empty_tables(MailTemplate, Document, Message, Teacher, User)
    end
    
    desc "Load MailTemplate development fixtures."
    task :mail_templates => ['populate:mail_template:user_application_confirmation', 'populate:mail_template:user_invitation', 'populate:mail_template:teacher_invitation']
    
    desc "Load Document development fixtures."
    task :documents => :environment do
      empty_tables(Document)
      create_documents(12)
    end
    
    desc "Load Message development fixtures."
    task :messages => :environment do
      empty_tables(Message)
      create_messages(46)
    end
    
    desc "Load Teacher development fixtures."
    task :teachers => :environment do
      empty_tables(Teacher)
      create_teachers(87)
    end
    
    desc "Load User development fixtures."
    task :users => :environment do
      empty_tables(User)
      create_users(87)
    end
    
    namespace :mail_template do
      desc "Add mail template for user application confirmation"
      task :user_application_confirmation => :environment do
        m = MailTemplate.find_by_title('user_application_confirmation')
        m.destroy if m
        puts "Creating the 'New message' mail template => "
        MailTemplate.create(:title => 'user_application_confirmation', :content => "Dear {{user.first_name}} {{user.last_name}},\nwe've received your request for participating in the Mintt program.\n\nTo confirm your demand, please click on the link below :\n{{user.confirmation_link}}\n\nThanks for your interest in the Mintt program,\n\nthe mintt team.")
        puts "Created the mail template 'user_application_confirmation'."
      end
      
      desc "Add mail template for user sign up"
      task :user_invitation => :environment do
        m = MailTemplate.find_by_title('user_invitation')
        m.destroy if m
        MailTemplate.create(:title => 'user_invitation', :content => "Dear {{user.first_name}} {{user.last_name}},\n\nHere is an invitation to sign-up on the mintt website, in order for you to access courses information and documents. \n\nTo create your account, please visit this page:\n{{user.invitation_link}}\n\nBest regards,\nthe mintt team.")
        puts "Created the mail template 'user_invitation'."
      end
      
      desc "Add mail template for teacher invitation"
      task :teacher_invitation => :environment do
        m = MailTemplate.find_by_title('teacher_invitation')
        m.destroy if m
        MailTemplate.create(:title => 'teacher_invitation', :content => "Dear {{teacher.email}},\n\nHere is an invitation to sign-up on the mintt website, in order for you to access courses information and documents.\n\nTo create your account, please visit this page:\n{{teacher.invitation_link}}\n\nBest regards,\nthe mintt team.")
        puts "Created the mail template 'teacher_invitation'."
      end
    end
  end
  
end

private

  def empty_tables(*tables)
    print "Deleting the content of #{tables.join(', ')}.. => "
    tables.each { |model| model.delete_all }
    print "#{tables.join(', ')} empty!\n\n"
  end
  
  def create_users(count)
    disable_perform_deliveries do
      print "Creating users => "
      count.times do |i|
        u = User.new
        u.gender = MALE_FEMALE.rand
        u.first_name = Faker::Name.first_name
        u.last_name = Faker::Name.last_name
        u.school = Faker::Lorem.sentence(1)
        u.lab = Faker::Lorem.sentence(1)
        u.email = Faker::Internet.email
        u.phone = Faker::PhoneNumber.phone_number
        u.url = "http://#{Faker::Internet.domain_name}"
        u.linkedin_url = "http://ch.linkedin.com/in/joeblow#{i}"
        u.thesis_supervisor = Faker::Name.name
        u.thesis_subject = Faker::Lorem.paragraphs
        u.thesis_registration_date = rand(1000).days.ago
        u.thesis_admission_date = rand(1000).days.from_now
        u.supervisor_authorization = YES_NO.rand
        u.doctoral_school_rules = YES_NO.rand
        u.thesis_invention = Faker::Lorem.paragraphs
        u.motivation = Faker::Lorem.paragraphs
        u.agreement = '1'
        u.save!
        u.confirmed_at = rand(10).days.ago#rand > 0.5 ? rand(10).days.ago : nil
        u.save!
      end
      print "#{count} users created.\n\n"
    end
  end
  
  def create_messages(count)
    disable_perform_deliveries do
      print "Creating messages => "
      count.times do |i|
        m = Message.new
        m.created_at = rand(25).days.ago
        m.sender_name = Faker::Name.first_name
        m.sender_email = Faker::Internet.email
        m.content = Faker::Lorem.paragraphs
        m.save!
        m.read_at = rand > 0.5 ? Date.new : nil
        m.replied_at = m.read? ? (rand > 0.5 ? Date.new : nil) : false
        m.save!
      end
      print "#{count} messages created.\n\n"
    end
  end
  
  def create_documents(count)
    count = 0
    print "Creating documents => "
    count.times do |i|
      d = Document.new
      d.title = Faker::Name.name
      d.description = Faker::Lorem.paragraphs
      d.filename = ''
      d.save!
    end
    print "#{count} document created.\n\n"
  end
  
  def disable_perform_deliveries(&block)
    if block_given?
      original_perform_deliveries = ActionMailer::Base.perform_deliveries
      # Disabling perform_deliveries (avoid to spam fakes email adresses)
      ActionMailer::Base.perform_deliveries = false
      
      yield
      
      # Switch back to the original perform_deliveries
      ActionMailer::Base.perform_deliveries = original_perform_deliveries
    else
      put "\n\nYou should pass a block to this method!\n\n"
    end
  end