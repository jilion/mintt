require 'spec_helper'

describe DeviseMailer do
  
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlWriter
  
  describe "creating a user" do
    
    before(:all) do 
      @user = Factory.create(:user)
      @email = DeviseMailer.create_confirmation_instructions(@user)
    end
    
    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end
    
    it "should render the liquid template with interpolation" do
      @email.should have_text("#{@user.first_name} #{@user.last_name} #{link_to('Confirm my application', { :host => Rails.env.production? ? MINTT_EPFL : MINTT_LOCAL, :controller => 'confirmations', :action => 'show', :confirmation_token => @user.confirmation_token })}\n")
    end
    
    it "should have the correct subject" do
      @email.should have_subject("Confirmation instructions")
    end
    
  end
  
end