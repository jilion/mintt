require 'spec_helper'

describe Devise::Mailer do

  include Mintt::Application.routes.url_helpers

  describe "application submitted" do
    before(:each) do
      @user = Factory(:user)
      Devise::Mailer.confirmation_instructions(@user).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it "is delivered from mintt's official email address" do
      @email.from.should == [SiteSettings.mintt_sender]
    end

    it "is delivered to the applicant's email" do
      @email.to.should == [@user.email]
    end

    it "has the correct subject" do
      @email.subject.should include I18n.t("devise.mailer.confirmation_instructions.subject")
    end

    it "contains link to confirm application" do
      @email.body.should include user_confirmation_url(:host => ActionMailer::Base.default_url_options[:host], :confirmation_token => @user.confirmation_token)
    end
  end

  describe "new teacher invitation" do
    before(:each) do
      @teacher = Teacher.invite!(:email => "test@test.com")
      Devise::Mailer.invitation_instructions(@teacher).deliver
      @email = ActionMailer::Base.deliveries.last
    end

    it "is delivered from mintt's official email address" do
      @email.from.should == [SiteSettings.mintt_sender]
    end

    it "is delivered to the applicant's email" do
      @email.to.should == [@teacher.email]
    end

    it "has the correct subject" do
      @email.subject.should include I18n.t("devise.mailer.invitation_instructions.teacher_subject")
    end

    it "contains link to accept invitation" do
      @email.body.should include accept_teacher_invitation_url(:host => ActionMailer::Base.default_url_options[:host], :invitation_token => @teacher.invitation_token)
    end
  end

end
