MALE_FEMALE = %w[male female]
YES_NO = %w[yes no]
TRUE_FALSE = [true, false]

namespace :db do
  
  desc "Load all development fixtures."
  task :populate => ['populate:empty_all_tables', 'populate:mail_templates', 'populate:messages', 'populate:users']
  
  namespace :populate do
    
    desc "Empty all the tables"
    task :empty_all_tables => :environment do
      empty_tables(MailTemplate, Message, User)
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
    
    desc "Load User development fixtures."
    task :users => :environment do
      empty_tables(User)
      create_users(87)
    end
    
  end
  
end

private
  def empty_tables(*tables)
    print "Deleting the content of #{tables}.. => "
    tables.each { |model| model.delete_all }
    print "#{tables} empty!\n\n"
  end

  def create_users(count)
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
      u.confirmed_at = rand > 0.5 ? Time.now.to_date : nil
      u.save!
    end
    print "#{count} users created.\n\n"
  end

  def create_messages(count)
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