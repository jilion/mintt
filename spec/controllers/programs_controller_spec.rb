require 'spec_helper'

describe ProgramsController do
  include Devise::TestHelpers
  before(:each) do
    Document.stub_chain(:where, :order_by).and_return([])
  end
  
  context "as a student" do
    before(:each) do
      @user = Factory(:user)
      @user.confirm!
      sign_in @user
    end
    
    it "should respond with success to GET :index" do
      get :index
      response.should be_success
      response.should render_template('programs/index')
    end
  end
  
  context "as a teacher" do
    before :each do
      @teacher = Teacher.invite(:email => "test@test.com")
      Teacher.accept_invitation(:invitation_token => @teacher.invitation_token, :password => '123456')
      @teacher.reload
      sign_in @teacher
    end
    
    it "should respond with success to GET :index" do
      get :index
      response.should be_success
      response.should render_template('programs/index')
    end
  end
  
  context "as a guest" do
    it "should respond with redirect to GET :index" do
      get :index
      response.should redirect_to(new_user_session_url)
    end
  end
  
end