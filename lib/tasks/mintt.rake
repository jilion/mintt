TRUE_FALSE = %w(1 0)
MALE_FEMALE = %w(male female)
YES_NO = %w(yes no)

namespace :db do
  
  desc "Load development fixtures."
  task :populate => :environment do
    empty_tables
    `rake db:seed RAILS_ENV=development`
    create_users(87)
    create_messages(46)
  end
  
end

private
  def empty_tables
    print "Deleting the content of MailTemplate, Message, User tables.. => "
    [MailTemplate, Message, User].each { |model| model.delete_all }
    print "empty!\n\n"
  end

  def create_users(count)
    print "Creating users => "
    count.times do |i|
      u = User.new
      u.gender = MALE_FEMALE.rand
      u.first_name = Faker::Name.first_name
      u.last_name = Faker::Name.last_name
      u.faculty = Faker::Lorem.words
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
      m.read = TRUE_FALSE.rand
      m.replied = m.read? ? TRUE_FALSE.rand : '0'
      m.save!
    end
    print "#{count} messages created.\n\n"
  end