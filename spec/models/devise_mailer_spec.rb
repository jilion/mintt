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
      @email.should have_text(/#{@user.email}/)
    end

    it "should contain a link to the confirmation link" do
      @email.should have_text(/#{Regexp.escape(user_confirmation_url(:host => ActionMailer::Base.default_url_options[:host], :confirmation_token => @user.confirmation_token))}/) # otherwise the '?' is not escaped and make the test fail
    end

    it "should have the correct subject" do
      @email.should have_subject("Confirmation instructions")
    end
  end

end
