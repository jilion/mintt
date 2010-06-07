require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers
  mock_model :user
  
  context "with applications open" do
    before(:each) do
      APPLICATIONS_OPEN = true
      sign_out :user
    end
    
    # =======
    # = new =
    # =======
    describe :get => :new do
      it { should render_template 'registrations/new.html.haml' }
    end
    
    # ==========
    # = create =
    # ==========
    describe :post => :create do
      expects :new, :on => User, :returns => mock_user
      expects :save, :on => mock_user, :returns => true
      
      it { should redirect_to root_url }
    end
    
    describe :post => :create do
      expects :new, :on => User, :returns => mock_user
      expects :save, :on => mock_user, :returns => false
      
      it { should render_template 'registrations/new.html.haml' }
    end
  end
  
  context "with applications closed" do
    before(:each) do
      APPLICATIONS_OPEN = false
      sign_out :user
    end
    
    # =======
    # = new =
    # =======
    describe :get => :new do
      it { should redirect_to root_url }
    end
    
    # ==========
    # = create =
    # ==========
    describe :post => :create do
      it { should redirect_to root_url }
    end
    
    describe :post => :create do
      it { should redirect_to root_url }
    end
  end
  
  context "with or without applications open" do
    before(:each) do
      @user = Factory(:user)
      @user.confirm!
      @user.select
      sign_in @user
    end
    
    # ========
    # = edit =
    # ========
    describe :get => :edit do
      expects :find, :find, :on => User, :returns => mock_user
      
      it { should render_template 'registrations/edit.html.haml' }
    end
    
    # ==========
    # = update =
    # ==========
    describe :put => :update do
      expects :find, :find, :on => User, :returns => mock_user
      expects :update_with_password, :on => mock_user, :returns => true
      
      it { should redirect_to edit_user_registration_path }
    end
    
    describe :put => :update do
      expects :find, :find, :on => User, :returns => mock_user
      expects :update_with_password, :on => mock_user, :returns => false
      
      it { should render_template 'registrations/edit.html.haml' }
    end
  end
  
end