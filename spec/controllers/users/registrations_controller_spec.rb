require 'spec_helper'

describe Users::RegistrationsController do
  include Devise::TestHelpers

  let(:new_user) { build(:user) }
  let(:user) { create(:user) }
  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context "with applications open" do
    before do
      SiteSettings.stub(:applications_open) { true }
      new_user
    end

    it "responds with redirect to GET :new" do
      get :new
      response.should render_template(:new)
    end

    it "responds with redirect to POST :create" do
      User.should_receive(:new).and_return(new_user)
      new_user.should_receive(:save) { true }

      post :create, :user => {}
      flash[:notice].should eq I18n.t('devise.registrations.user.signed_up_but_unconfirmed')
      flash[:alert].should be_nil
      response.should redirect_to(root_url)
    end

    it "responds with redirect to POST :create" do
      User.should_receive(:new).and_return(new_user)
      new_user.should_receive(:save) { false }

      post :create, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should be_nil
      response.should render_template(:new)
    end
  end

  context "with applications closed" do
    before do
      SiteSettings.stub(:applications_open).and_return(false)
    end

    it "responds with redirect to GET :new" do
      get :new
      flash[:notice].should be_nil
      flash[:alert].should eq I18n.t('devise.registrations.user.applications_closed')
      response.should redirect_to(root_url)
    end

    it "responds with redirect to POST :create" do
      post :create, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should eq I18n.t('devise.registrations.user.applications_closed')
      response.should redirect_to(root_url)
    end

    it "responds with redirect to POST :create" do
      post :create, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should eq I18n.t('devise.registrations.user.applications_closed')
      response.should redirect_to(root_url)
    end
  end

  context "with logged-in user" do
    before do
      user.confirm!
      user.update_attribute(:state, 'selected')
      sign_in user
    end

    it "responds with redirect to PUT :update successful" do
      User.should_receive(:find).and_return(user)
      user.should_receive(:update_with_password) { true }

      put :update, :user => {}
      flash[:notice].should eq I18n.t('devise.registrations.updated')
      flash[:alert].should be_nil
      response.should redirect_to(program_path)
    end

    it "responds with success to PUT :update unsuccessful" do
      User.should_receive(:find).and_return(user)
      user.should_receive(:update_with_password) { false }

      put :update, :user => {}
      flash[:notice].should be_nil
      flash[:alert].should be_nil
      response.should render_template('devise/registrations/edit')
    end
  end

end
