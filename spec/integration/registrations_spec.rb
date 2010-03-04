require 'spec_helper'

describe "Registrations" do

  before(:each) do
    ActionMailer::Base.deliveries.clear
    Factory.create(:mail_template)
  end

  it "should be possible to register" do
    register
    response.should contain('You will receive an email with instructions about how to confirm your registration in a few minutes.')
  end

  it "should deliver the 'confirm registration' email" do
    register
    ActionMailer::Base.deliveries.size.should == 1
  end

end

def register
  visit root_path
  click_link "registration_button"

  choose "user_gender_male"
  fill_in "user_first_name", :with => "Joe"
  fill_in "user_last_name",  :with => "Blow"
  fill_in "user_faculty",    :with => "Computer Science"
  fill_in "user_email",      :with => "remy@jilion.com"
  fill_in "user_phone",      :with => "0 21 000 00 00"
  fill_in "user_url",        :with => "http://jilion.com"
  fill_in "user_linkedin_url", :with => "http://fr.linkedin.com/in/remycoutable"
  fill_in "user_thesis_supervisor", :with => "Remy Coutable"
  fill_in "user_thesis_subject", :with => "Advanced Compilation for Mac"
  select_date "April 2, 2010", :from => "Thesis registration date", :id_prefix => 'user_thesis_registration_date'
  select_date "April 26, 2010", :from => "Thesis admission date", :id_prefix => 'user_thesis_admission_date'
  choose "user_supervisor_authorization_yes"
  choose "user_doctoral_school_rules_yes"
  fill_in "user_thesis_invention", :with => "The iPad"
  fill_in "user_motivation", :with => "Huge!"
  check "user_agreement"
  click_button "Register"
end