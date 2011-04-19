require 'spec_helper'

describe Admin::Teachers::InvitationsController do

  context "as an admin" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:teacher]
    end

    it "responds with success to GET :new" do
      get :new
      response.should be_success
      response.should render_template('admin/teachers/invitations/new', :layout => 'admin')
    end

    it "responds with success to POST :create successful" do
      Teacher.should_receive(:invite!).and_return(mock_teacher(:email => "remy@jilion.com", :errors => []))

      post :create, :teacher => {}
      flash[:notice].should == I18n.t("devise.invitations.send_instructions", :email => "remy@jilion.com")
      flash[:alert].should be_nil
      response.should redirect_to(admin_teachers_path)
    end

    it "responds with success to POST :create unsuccessful" do
      Teacher.should_receive(:invite!).and_return(mock_teacher(:errors => ['error!']))

      post :create, :teacher => {}
      flash[:notice].should be_nil
      flash[:alert].should be_nil
      response.should be_success
      response.should render_template('admin/teachers/invitations/new', :layout => 'admin')
    end
  end

end
