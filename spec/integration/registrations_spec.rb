require 'spec_helper'

describe "Registrations" do
  
  it "should be possible to register" do
    visit root_path
    click_link "Register for the 2010 course"
    fill_in "First name", :with => "John"
    fill_in "Last name",  :with => "Doe"
    fill_in "Faculty",    :with => "Computer Science"
    fill_in "Email",      :with => "john@doe.com"
    fill_in "Phone",      :with => "+41 21 0000000"
    fill_in "Url",        :with => "johndoe"
    fill_in "Password",   :with => "123456"
    check "I agree to terms of service"
    click_button "Sign up"
    response.should contain("You have signed up successfully.")
    response.should contain("John Doe")
    response.should contain("logout")
    current_url.should == "http://www.example.com/documents"
  end
  
end
