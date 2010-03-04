# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require 'faker'

case Rails.env
when 'development'
  MailTemplate.create(:title => 'new_message', :content => '{{user.first_name}} {{user.last_name}}')
  p "Mail template { :title => 'new_message', :content => '{{user.first_name}} {{user.last_name}}' } created\n\n"
  
  YES_NO = %w(yes no)
  100.times do |i|
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
    u.thesis_registration_date = rand(100).days.ago
    u.thesis_admission_date = rand(100).days.from_now
    u.supervisor_authorization = YES_NO.rand
    u.doctoral_school_rules = YES_NO.rand
    u.thesis_invention = Faker::Lorem.paragraphs
    u.motivation = Faker::Lorem.paragraphs
    u.agreement = '1'
    u.save!
  end
  p "100 users created."
  
end