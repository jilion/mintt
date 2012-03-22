require 'spec_helper'

describe ProgramsController do
  include Devise::TestHelpers
  before do
    Document.stub_chain(:year, :published, :order_by).and_return([])
  end

  context "as a student" do
    before do
      @user = Factory(:user)
      @user.confirm!
      @user.update_attribute(:state, 'selected')
      sign_in @user
    end

    it "responds with success to GET :index" do
      get :index
      response.should render_template(:index)
    end
  end

  context "as a teacher" do
    before do
      @teacher = Teacher.invite!(:email => "test@test.com", :years => [Time.now.year])
      Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456')
      @teacher.reload
      sign_in @teacher
    end

    it "responds with success to GET :index" do
      get :index
      response.should render_template(:index)
    end
  end

  context "as a guest" do
    it "responds with redirect to GET :index" do
      get :index
      response.should redirect_to(new_user_session_url)
    end
  end

end
