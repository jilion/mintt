require 'spec_helper'

describe DocumentsController do
  include Devise::TestHelpers
  before(:each) do
    @f = mock('file', :original_filename => 'course_document.pdf', :read => '', :path => '')
    @doc = Factory(:document, :file => @f, :published_at => Time.utc(2010,3,1))
  end

  context "as an admin" do
    before(:each) do
      controller.should_receive(:admin?).twice { true }
    end

    it "responds with success to GET :show" do
      Document.should_receive(:find).with(1) { @doc }

      get :show, :id => 1
      response.should be_success
    end
  end

  context "as a student" do
    before(:each) do
      controller.should_receive(:admin?).twice { false }
    end
    
    context "selected in the year the document was published" do
      before(:each) do
        @user = Factory(:user, :year => 2010)
        @user.confirm!
        sign_in @user
      end

      it "responds with success to GET :show" do
        Document.should_receive(:find).with(1) { @doc }

        get :show, :id => 1
        response.should be_success
      end
    end

    context "not selected in the year the document was published" do
      before(:each) do
        @user = Factory(:user, :year => 2011)
        @user.confirm!
        sign_in @user
      end

      it "responds with success to GET :show" do
        Document.should_receive(:find).with(1) { @doc }

        get :show, :id => 1
        puts @user.year
        puts @doc.published_at.year
        response.status.should == 403
      end
    end
  end

  context "as a teacher" do
    before(:each) do
      controller.should_receive(:admin?).twice { false }
    end
    
    context "active in the year the document was published" do
      before :each do
        @teacher = Teacher.invite!(:email => "test@test.com")
        Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456', :years => [2010, 2011])
        @teacher.reload
        sign_in @teacher
      end

      it "responds with success to GET :show" do
        Document.should_receive(:find).with(1) { @doc }

        get :show, :id => 1
        response.should be_success
      end
    end

    context "not active in the year the document was published" do
      before :each do
        @teacher = Teacher.invite!(:email => "test@test.com")
        Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456', :years => [2011])
        @teacher.reload
        sign_in @teacher
      end

      it "responds with success to GET :show" do
        Document.should_receive(:find).with(1) { @doc }

        get :show, :id => 1
        response.status.should == 403
      end
    end
  end

  context "as a guest" do
    before(:each) do
      controller.should_receive(:admin?) { false }
    end

    it "responds with redirect to GET :show" do
      get :show, :id => 1
      response.should redirect_to(new_user_session_url)
    end
  end
end
