require 'faker'

class Seeds

  TRUE_FALSE = %w(1 0)
  YES_NO = %w(yes no)

  class << self
    def development_seeds
      empty_tables
      create_new_message_mail_template
      create_users(87)
      create_messages(46)
    end

    def test_seeds
      empty_tables
    end

    def production_seeds
      create_new_message_mail_template
      create_users(87)
      create_messages(46)
    end


    def empty_tables
      print "Deleting the content of MailTemplate, Message, User tables.. => "
      [MailTemplate, Message, User].each { |model| model.delete_all }
      print "empty!\n\n"
    end

    def create_users(count)
      print "Creating users => "
      count.times do |i|
        u = User.new
        u.gender = 'male'
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
      print "#{count} users created.\n\n"end

      def create_messages(count)
        print "Creating messages => "
        count.times do |i|
          m = Message.new
          m.created_at = rand(10000).hours.from_now
          m.sender_name = Faker::Name.first_name
          m.sender_email = Faker::Internet.email
          m.content = Faker::Lorem.paragraphs
          m.replied
          m.save!
          m.read = TRUE_FALSE.rand
          m.replied = m.read? ? TRUE_FALSE.rand : '0'
          m.save!
        end
        print "#{count} messages created.\n\n"
      end

      def create_new_message_mail_template
        print "Creating the 'New message' mail template => "
        MailTemplate.create(:title => 'new_message', :content => "Dear {{user.first_name}} {{user.last_name}},\nwe've received your request for participating in the Mintt program.\n\nTo confirm you demand, please click on the link below :\n{{user.confirmation_link}}\n\n\nThanks for your interest in the Mintt program,\n\nthe whole Mintt team.")
        print "created.\n\n"
      end
    end
  end

  case Rails.env
  when 'development'
    Seeds.development_seeds
  when 'test'
    Seeds.test_seeds
  when 'production'
    Seeds.production_seeds
  end