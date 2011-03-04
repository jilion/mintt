require 'spec_helper'

describe Users::ApplicationsController do
  include Devise::TestHelpers

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context "with applications open" do
    before(:each) do
      SiteSettings.stub(:applications_open).and_return(true)
    end

    it "should respond with redirect to GET :new" do
      get :new
      response.should be_success
      response.should render_template('applications/new')
    end

    it "should respond with redirect to POST :create" do
      User.stub(:new).and_return(mock_user)
      mock_user.stub(:save).and_return(true)
      post :create, :user => {}
      response.should redirect_to(root_url)
    end

    it "should respond with redirect to POST :create" do
      User.stub(:new).and_return(mock_user)
      mock_user.stub(:save).and_return(false)
      post :create, :user => {}
      response.should be_success
      response.should render_template('applications/new')
    end
  end

  context "with applications closed" do
    before(:each) do
      SiteSettings.stub(:applications_open).and_return(false)
    end

    it "should respond with redirect to GET :new" do
      get :new
      response.should redirect_to(root_url)
    end

    it "should respond with redirect to POST :create" do
      post :create, :user => {}
      response.should redirect_to(root_url)
    end

    it "should respond with redirect to POST :create" do
      post :create, :user => {}
      response.should redirect_to(root_url)
    end
  end

end