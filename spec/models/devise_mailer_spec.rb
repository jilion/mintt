require 'spec_helper'

describe DeviseMailer do
  
  include ActionController::UrlWriter
  
  describe "creating a user" do
    
    before(:all) do 
      @user = Factory.create(:user)
      @email = DeviseMailer.create_confirmation_instructions(@user)
    end
    
    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end
    
    it "should contain the user's email in the mail body" do
      @email.should have_text(/<#{@user.email}>/)
    end
    
    it "should render the liquid template with interpolation" do
      @email.should have_text(/#{@user.first_name} #{@user.last_name}<#{@user.email}>\n\nThat's a demo template!/)
    end
    
    it "should have the correct subject" do
      @email.should have_subject("Confirmation instructions")
    end
    
  end
  
end