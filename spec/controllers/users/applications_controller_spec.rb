require 'spec_helper'

describe Users::ApplicationsController do
  include Devise::TestHelpers

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context "with applications open" do
    before(:each) do
      SiteSettings.stub(:applications_open) { true }
    end

    it "responds with redirect to GET :new" do
      get :new
      response.should be_success
      response.should render_template('applications/new')
    end

    it "responds with redirect to POST :create" do
      User.should_receive(:new).and_return(mock_user)
      mock_user.should_receive(:save) { true }

      post :create, :user => {}
      flash[:notice].should == I18n.t('devise.applications.send_instructions')
      flash[:alert].should be_nil
      response.should redirect_to(root_url)
    end

    it "responds with redirect to POST :create" do
      User.should_receive(:new).and_return(mock_user)
      mock_user.should_receive(:save) { false }

      post :create, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should be_nil
      response.should be_success
      response.should render_template('applications/new')
    end
  end

  context "with applications closed" do
    before(:each) do
      SiteSettings.stub(:applications_open).and_return(false)
    end

    it "responds with redirect to GET :new" do
      get :new
      flash[:notice].should be_nil
      flash[:alert].should == I18n.t('devise.applications.applications_closed')
      response.should redirect_to(root_url)
    end

    it "responds with redirect to POST :create" do
      post :create, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should == I18n.t('devise.applications.applications_closed')
      response.should redirect_to(root_url)
    end

    it "responds with redirect to POST :create" do
      post :create, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should == I18n.t('devise.applications.applications_closed')
      response.should redirect_to(root_url)
    end
  end

end
