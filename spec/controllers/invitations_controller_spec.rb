require 'spec_helper'

describe InvitationsController do
  include Devise::TestHelpers
  mock_model :teacher
  
  context "as an admin" do
    before :each do
      @mock_teacher = mock_model(Teacher)
      Teacher.stub(:new).and_return(@mock_teacher)
      Teacher.stub(:send_invitation).and_return(@mock_teacher)
    end
    
    it "should respond with success to GET :new" do
      get :new
      response.should be_success
      response.should render_template 'invitations/new.html.haml'
    end
    
    it "should respond with success to POST :create" do
      @mock_teacher.stub_chain(:errors, :empty?).and_return(true)
      post :create
      response.should be_redirect
      response.should redirect_to admin_teachers_path
    end
    
    it "should respond with success to POST :create" do
      @mock_teacher.stub_chain(:errors, :empty?).and_return(false)
      post :create
      response.should be_success
      response.should render_template 'invitations/new.html.haml'
    end
  end
  
  context "as an invited teacher" do
    before :each do
      @mock_teacher = mock_model(Teacher, :invitation_token= => true)
      Teacher.stub(:new).and_return(@mock_teacher)
      Teacher.stub(:accept_invitation!).and_return(@mock_teacher)
    end
    
    it "should respond with success to GET :new" do
      get :edit
      response.should be_success
      response.should render_template 'invitations/edit.html.haml'
    end
    
    it "should respond with success to PUT :update" do
      @mock_teacher.stub_chain(:errors, :empty?).and_return(true)
      put :update
      response.should be_redirect
      response.should redirect_to teacher_root_path
    end
    
    it "should respond with success to PUT :update" do
      @mock_teacher.stub_chain(:errors, :empty?).and_return(false)
      put :update
      response.should be_success
      response.should render_template 'invitations/edit.html.haml'
    end
  end
  
end