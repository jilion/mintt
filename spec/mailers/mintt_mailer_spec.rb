require 'spec_helper'

describe MinttMailer do

  include Mintt::Application.routes.url_helpers

  describe "new message" do
    before(:each) do
      @message = Factory(:message)
      MinttMailer.new_message(@message).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it "is delivered from mintt's official email address" do
      @email.from.should == [SiteSettings.mintt_sender.gsub(/[\w ]+<([\w@.]+)>/, '\1')]
    end

    it "is delivered to the email passed in" do
      @email.to.should == SiteSettings.new_message_recipients
    end

    it "has the correct subject" do
      @email.subject.should include I18n.t("new_contact_message")
    end

    it "contains the user's message in the email body" do
      @email.body.should include @message.content
    end

    it "contains a link to the message view in the admin" do
      @email.body.should include admin_message_url(@message, :host => ActionMailer::Base.default_url_options[:host])
    end

  end

  describe "sign up" do
    before(:each) do
      @user  = Factory(:user, :state => 'selected')
      MinttMailer.sign_up_instructions(@user).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it "is delivered from mintt's official email address" do
      @email.from.should == [SiteSettings.mintt_sender.gsub(/[\w ]+<([\w@.]+)>/, '\1')]
    end

    it "is delivered to the user's email passed in" do
      @email.to.should == [@user.email]
    end

    it "has the correct subject" do
      @email.subject.should include I18n.t("devise.mailer.sign_up_instructions.user_subject")
    end

    it "contains a link to user's reset_password_token in the email body" do
      @email.body.should include edit_user_password_url(:host => ActionMailer::Base.default_url_options[:host], :reset_password_token => @user.reset_password_token)
    end

  end

end
