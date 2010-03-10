require 'spec_helper'

describe MessageMailer do
  
  include ActionController::UrlWriter
  
  describe "new message" do
    
    before(:all) do
      @message = Factory.create(:message)
      @email = MessageMailer.create_new_message(@message)
    end
    
    it "should be delivered from mintt's official email adress" do
      @email.should deliver_from(MINTT_SENDER)
    end
    
    it "should deliver to the email passed in" do
      @email.should deliver_to(NEW_MESSAGE_RECIPIENTS)
    end
    
    it "should have the correct subject" do
      @email.should have_subject("[Mintt] New contact message")
    end
    
    it "should contain the user's message in the email body" do
      @email.should have_text(/#{@message.content}/)
    end
    
    it "should contain a link to the message view in the admin" do
      @email.should have_text(/#{admin_message_url(@message, :host => ActionMailer::Base.default_url_options[:host])}/)
    end
    
  end
  
end