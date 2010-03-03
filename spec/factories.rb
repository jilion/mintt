Factory.define :user, :default_strategy => :build do |u|
  u.gender "male"
  u.first_name 'Joe'
  u.last_name  'Blow'
  u.faculty "Computer Science"
  u.sequence(:email)  { |n| "email#{n}@epfl.com" }
  u.phone "+41 21 0000000"
  u.url "http://jilion.com"
  u.linkedin_url "http://fr.linkedin.com/in/remycoutable"
  u.thesis_supervisor "Remy Coutable"
  u.thesis_subject "Advanced Compilation for Mac"
  u.thesis_registration_date Time.now
  u.thesis_admission_date 1.month.from_now
  u.supervisor_authorization "yes"
  u.doctoral_school_rules "yes"
  u.thesis_invention "The iPad"
  u.motivation "Huge!"
  u.agreement "1"
end

Factory.define :message, :default_strategy => :build do |u|
  u.sender_name 'Joe Blow'
  u.sequence(:sender_email)  { |n| "email#{n}@epfl.com" }
  u.content "Advanced Compilation for Mac"
end
