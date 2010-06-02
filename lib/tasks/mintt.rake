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
      empty_tables(MailTemplate, Message, Teacher, User)
    end
    
    desc "Load MailTemplate development fixtures."
    task :mail_templates => :environment do
      empty_tables(MailTemplate)
      `rake db:seed RAILS_ENV=development`
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
      desc "Add mail template for user sign up"
      task :user_sign_up => :environment do
        m = MailTemplate.find_by_title('user_sign_up')
        m.destroy if m
        MailTemplate.create(:title => 'user_sign_up', :content => "Dear {{user.first_name}} {{user.last_name}},\nwe are honored to accept you in the mintt program.\n\nAn account has been created for you on http://mintt.epfl.ch, start using it by setting your password. To do so, please click on the link below:\n{{user.set_password_link}}\n\nThanks for your interest in the mintt program,\n\nthe whole Mintt team.")
        puts "Created the mail template 'user_sign_up'."
      end
      
      desc "Add mail template for teacher invitation"
      task :teacher_invitation => :environment do
        m = MailTemplate.find_by_title('teacher_invitation')
        m.destroy if m
        MailTemplate.create(:title => 'teacher_invitation', :content => "Hello {{teacher.email}}!\n\nSomeone has invited you to http://mintt.epfl.ch, you can accept it through the link below:\n{{teacher.invitation_link}}\n\nIf you don't want to accept the invitation, please ignore this email.\n\nYour account won't be created until you access the link above and set your password.")
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
    action_mailer_perform_deliveries = ActionMailer::Base.perform_deliveries
    # Disabling perform_deliveries (avoid to spam fakes email adresses)
    ActionMailer::Base.perform_deliveries = false
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
      u.confirmed_at = rand > 0.5 ? rand(10).days.ago : nil
      u.save!
    end
    print "#{count} users created.\n\n"
    # Switch back to the original perform_deliveries
    ActionMailer::Base.perform_deliveries = action_mailer_perform_deliveries
  end

  def create_messages(count)
    action_mailer_perform_deliveries = ActionMailer::Base.perform_deliveries
    # Disabling perform_deliveries (avoid to spam fakes email adresses)
    ActionMailer::Base.perform_deliveries = false
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
    # Switch back to the original perform_deliveries
    ActionMailer::Base.perform_deliveries = action_mailer_perform_deliveries
  end