require 'spec_helper'

describe MinttMailer do
  
  include ActionController::UrlWriter
  
  describe "new message" do
    
    before(:all) do
      @message = Factory(:message)
      @email   = MinttMailer.create_new_message(@message)
    end
    
    it "should be delivered from mintt's official email address" do
      @email.should deliver_from(MINTT_SENDER)
    end
    
    it "should deliver to the email passed in" do
      @email.should deliver_to(NEW_MESSAGE_RECIPIENTS)
    end
    
    it "should have the correct subject" do
      @email.should have_subject("[mintt] New contact message")
    end
    
    it "should contain the user's message in the email body" do
      @email.should have_text(/#{@message.content}/)
    end
    
    it "should contain a link to the message view in the admin" do
      @email.should have_text(/#{admin_message_url(@message, :host => ActionMailer::Base.default_url_options[:host])}/)
    end
    
  end
  
  describe "sign up" do
    
    before(:all) do
      @user  = Factory(:user)
      @user.select
      @email = MinttMailer.create_sign_up_instructions(@user)
    end
    
    it "should be delivered from mintt's official email address" do
      @email.should deliver_from(MINTT_SENDER)
    end
    
    it "should deliver to the user's email passed in" do
      @email.should deliver_to(@user.email)
    end
    
    it "should have the correct subject" do
      @email.should have_subject("[mintt] Invitation to sign-up on the mintt website")
    end
    
    it "should contain a link to user's reset_password_token in the email body" do
      @email.should have_text(/http:\/\/mintt\.local\/users\/password\/edit\?reset_password_token=#{@user.reset_password_token}/)
    end
    
  end
  
end