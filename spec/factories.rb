Factory.define :user do |u|
  u.gender true # male
  u.first_name 'Joe'
  u.last_name  'Blow'
  u.faculty "Computer Science"
  u.sequence(:email)  { |n| "email#{n}@epfl.com" }
  u.phone "+41 21 0000000"
  u.url "http://jilion.com"
  u.linkedin_url "http://fr.linkedin.com/in/remycoutable"
  u.thesis_supervisor "Remy Coutable"
  u.thesis_subject "Advanced Compilation for Mac"
  u.supervisor_authorization true
  u.doctoral_school_rules true
  u.thesis_invention "The iPad"
  u.motivation "Huge!"
  u.agreement true
end
