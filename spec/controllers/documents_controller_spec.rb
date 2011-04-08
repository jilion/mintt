require 'spec_helper'

describe DocumentsController do
  include Devise::TestHelpers

  context "as an admin" do
    before(:each) do
      controller.should_receive(:admin?) { true }
    end

    it "should respond with success to GET :show" do
      Document.should_receive(:find).with(1) { mock_document(:path => Rails.root.join("spec/fixtures/coursé_document.pdf"), :filename => 'coursé_document.pdf', :mime_type => 'application/pdf') }

      get :show, :id => 1
      response.should be_success
    end
  end

  context "as a student" do
    before(:each) do
      @user = Factory(:user)
      @user.confirm!
      sign_in @user
    end

    it "should respond with success to GET :show" do
      Document.should_receive(:find).with(1) { mock_document(:path => Rails.root.join("spec/fixtures/coursé_document.pdf"), :filename => 'coursé_document.pdf', :mime_type => 'application/pdf') }

      get :show, :id => 1
      response.should be_success
    end
  end

  context "as a teacher" do
    before :each do
      @teacher = Teacher.invite!(:email => "test@test.com")
      Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456')
      @teacher.reload
      sign_in @teacher
    end

    it "should respond with success to GET :show" do
      Document.should_receive(:find).with(1) { mock_document(:path => Rails.root.join("spec/fixtures/coursé_document.pdf"), :filename => 'coursé_document.pdf', :mime_type => 'application/pdf') }
      
      get :show, :id => 1
      response.should be_success
    end
  end

  context "as a guest" do
    before(:each) do
      controller.should_receive(:admin?) { false }
    end
    
    it "should respond with redirect to GET :show" do
      get :show, :id => 1
      response.should redirect_to(new_user_session_url)
    end
  end
end
