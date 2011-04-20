Factory.define :user do |f|
  f.gender                   'male'
  f.first_name               'John'
  f.last_name                'Doe'
  f.school                   "Computer Science"
  f.lab                      "Apple Lab"
  f.sequence(:email)         { |n| "email#{n}@epfl.com" }
  f.phone                    "+41 21 0000000"
  f.url                      "http://jilion.com"
  f.linkedin_url             "http://fr.linkedin.com/in/remycoutable"
  f.thesis_supervisor        "Remy Coutable"
  f.thesis_subject           "Advanced Compilation for Mac"
  f.thesis_registration_date 1.hour.from_now
  f.thesis_admission_date    1.month.from_now
  f.supervisor_authorization "yes"
  f.doctoral_school_rules    "yes"
  f.thesis_invention         "The iPad"
  f.motivation               "Huge!"
  f.agreement                "1"
  f.state                    "candidate"
end


Factory.define :teacher do |f|
  f.name             'John Doe'
  f.sequence(:email) { |n| "email#{n}@epfl.com" }
  f.password         '123456'
  f.years            [Time.now.utc.year]
end

Factory.define :document do |f|
  f.sequence(:title) { |n| "A document #{n}" }
  f.module_id        1
  f.published_at     Time.now.utc
end

Factory.define :teaching_module do |f|
  f.sequence(:title) { |n| "Evaluate the Potential #{n}" }
  f.year                 2010
end


Factory.define :message do |f|
  f.sender_name             "John Doe"
  f.sequence(:sender_email) { |n| "email#{n}@epfl.com" }
  f.content                 "Advanced Compilation for Mac"
end


Factory.define :mail_template do |f|
  f.sequence(:title)   { |n| "test template #{n}" }
  f.content            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor."
end

Factory.define :user_application_confirmation, :class => MailTemplate do |f|
  f.title   'user_application_confirmation'
  f.content '{{user.first_name}} {{user.last_name}} {{user.confirmation_link}}'
end

Factory.define :user_invitation, :class => MailTemplate do |f|
  f.title   'user_invitation'
  f.content '{{user.first_name}} {{user.last_name}} {{user.invitation_link}}'
end

Factory.define :teacher_invitation, :class => MailTemplate do |f|
  f.title   'teacher_invitation'
  f.content '{{teacher.email}} {{teacher.invitation_link}}'
end
