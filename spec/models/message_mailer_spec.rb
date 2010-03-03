require 'spec_helper'

describe MessageMailer do
  include ActionController::UrlWriter

  before(:all) do
    @message = Factory.create(:message)
    @email = MessageMailer.create_new_message(@message)
  end

  it "should be set to be delivered to the email passed in" do
    @email.should deliver_to(NEW_MESSAGE_RECIPIENT)
  end

  it "should contain the user's message in the mail body" do
    @email.should have_text(/#{@message.content}/)
  end

  it "should contain a link to the confirmation link" do
    @email.should have_text(/#{admin_message_url(@message, :host => ActionMailer::Base.default_url_options[:host])}/)
  end

  it "should have the correct subject" do
    @email.should have_subject("[Mintt] New contact message")
  end

end
