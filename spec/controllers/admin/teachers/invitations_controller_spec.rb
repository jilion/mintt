require 'spec_helper'

describe Admin::Teachers::InvitationsController do

  context "as an admin" do
    before(:each) do
      Teacher.stub(:new).and_return(mock_teacher)
      Teacher.stub(:invite).and_return(mock_teacher)
      request.env['devise.mapping'] = Devise.mappings[:teacher]
    end

    it "should respond with success to GET :new" do
      get :new
      response.should be_success
      response.should render_template('admin/teachers/invitations/new', :layout => 'admin')
    end

    it "should respond with success to POST :create successful" do
      mock_teacher.stub(:invited?).and_return(true)
      post :create, :teacher => {}
      response.should redirect_to(admin_teachers_path)
    end

    it "should respond with success to POST :create unsuccessful" do
      mock_teacher.stub(:invited?).and_return(false)
      post :create, :teacher => {}
      response.should be_success
      response.should render_template('admin/teachers/invitations/new', :layout => 'admin')
    end
  end

end
