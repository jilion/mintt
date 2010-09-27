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
  f.name             'John'
  f.sequence(:email) { |n| "email#{n}@epfl.com" }
  f.password         '123456'
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

Factory.define :document do |f|
  f.title     'A document'
  f.module_id 1
  f.filename  "course_document.pdf"
end