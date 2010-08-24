require 'spec_helper'

describe Devise::Mailer do
  
  include ActionView::Helpers::UrlHelper
  include Mintt::Application.routes.url_helpers
  
  describe "application submitted" do
    
    before(:all) do
      @user = Factory.create(:user)
      Devise::Mailer.confirmation_instructions(@user).deliver
      @email = ActionMailer::Base.deliveries.last
    end
    
    it "should be delivered from mintt's official email adress" do
      @email.should deliver_from(MINTT_SENDER)
    end
    
    it "should be delivered to the applicant's email" do
      @email.should deliver_to(@user.email)
    end
    
    it "should render the liquid template with interpolation" do
      @email.should have_text("#{@user.first_name} #{@user.last_name} #{url_for({ :host => MINTT_LOCAL, :only_path => false, :controller => 'confirmations', :action => 'show', :confirmation_token => @user.confirmation_token })}\n")
    end
    
    it "should have the correct subject" do
      @email.should have_subject("Confirmation instructions")
    end
    
  end
  
end