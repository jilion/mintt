FactoryGirl.define do
  factory :user do
    gender                   'male'
    first_name               'John'
    last_name                'Doe'
    school_and_lab           'EPFL IC ISC LCAV'
    sequence(:email)         { |n| "email#{n}@epfl.com" }
    phone                    "+41 21 0000000"
    url                      "http://jilion.com"
    linkedin_url             "http://fr.linkedin.com/in/remycoutable"
    thesis_supervisor        "Remy Coutable"
    thesis_subject           "Advanced Compilation for Mac"
    thesis_registration_date 1.hour.from_now
    thesis_admission_date    1.month.from_now
    supervisor_authorization "yes"
    doctoral_school_rules    "yes"
    thesis_invention         "The iPad"
    motivation               "Huge!"
    agreement                "1"
    state                    "candidate"
  end

  factory :teacher do
    name             'John Doe'
    sequence(:email) { |n| "email#{n}@epfl.com" }
    password         '123456'
    years            [Time.now.utc.year]
  end

  factory :document do
    sequence(:title) { |n| "A document #{n}" }
    module_id        1
    published_at     Time.now.utc
  end

  factory :teaching_module do
    sequence(:title) { |n| "Evaluate the Potential #{n}" }
    year                 2010
  end

  factory :message do
    sender_name             "John Doe"
    sequence(:sender_email) { |n| "email#{n}@epfl.com" }
    content                 "Advanced Compilation for Mac"
  end

  factory :mail_template do
    sequence(:title)   { |n| "test template #{n}" }
    content            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor."
  end

  factory :user_application_confirmation, :class => MailTemplate do
    title   'user_application_confirmation'
    content '{{user.first_name}} {{user.last_name}} {{user.confirmation_link}}'
  end

  factory :user_invitation, :class => MailTemplate do
    title   'user_invitation'
    content '{{user.first_name}} {{user.last_name}} {{user.invitation_link}}'
  end

  factory :teacher_invitation, :class => MailTemplate do
    title   'teacher_invitation'
    content '{{teacher.email}} {{teacher.invitation_link}}'
  end

end
