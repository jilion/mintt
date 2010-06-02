Factory.define :user do |u|
  u.gender                   'male'
  u.first_name               'John'
  u.last_name                'Doe'
  u.school                   "Computer Science"
  u.lab                      "Apple Lab"
  u.sequence(:email)         { |n| "email#{n}@epfl.com" }
  u.phone                    "+41 21 0000000"
  u.url                      "http://jilion.com"
  u.linkedin_url             "http://fr.linkedin.com/in/remycoutable"
  u.thesis_supervisor        "Remy Coutable"
  u.thesis_subject           "Advanced Compilation for Mac"
  u.thesis_registration_date 1.hour.from_now
  u.thesis_admission_date    1.month.from_now
  u.supervisor_authorization "yes"
  u.doctoral_school_rules    "yes"
  u.thesis_invention         "The iPad"
  u.motivation               "Huge!"
  u.agreement                "1"
end

Factory.define :teacher do |u|
  u.name             'John'
  u.sequence(:email) { |n| "email#{n}@epfl.com" }
end

Factory.define :message do |m|
  m.sender_name             "John Doe"
  m.sequence(:sender_email) { |n| "email#{n}@epfl.com" }
  m.content                 "Advanced Compilation for Mac"
end

Factory.define :mail_template do |m|
  m.title   'test_template'
  m.content "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
end
