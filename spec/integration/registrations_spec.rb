require 'spec_helper'

describe "Registrations" do
  
  it "should be possible to register" do
    basic_auth('fake', 'fake')
    visit root_path
    click_link "registration_button"
    # save_and_open_page
    
    choose "user_gender_true"
    fill_in "user_first_name", :with => "John"
    fill_in "user_last_name",  :with => "Doe"
    fill_in "user_faculty",    :with => "Computer Science"
    fill_in "user_email",      :with => "remy@jilion.com"
    fill_in "user_phone",      :with => "+41 21 0000000"
    fill_in "user_url",        :with => "http://jilion.com"
    fill_in "user_linkedin_url", :with => "http://fr.linkedin.com/in/remycoutable"
    fill_in "user_thesis_supervisor", :with => "Remy Coutable"
    fill_in "user_thesis_subject", :with => "Advanced Compilation for Mac"
    choose "user_supervisor_authorization_true"
    choose "user_doctoral_school_rules_true"
    fill_in "user_thesis_invention", :with => "The iPad"
    fill_in "user_motivation", :with => "Huge!"
    check "user_agreement_true"
    click_button "Register"
    # save_and_open_page
    
    response.should contain('You will receive an email with instructions about how to confirm your registration in a few minutes.')
  end
  
end
