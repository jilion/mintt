require 'spec_helper'

describe Admin::UsersController do
  mock_model :user
  
  # =========
  # = index =
  # =========
  describe :get => :index, :page => 2 do
    expects :paginate_order_by, :on => User, :with => [{}, { :page => "2" }], :returns => mock_users
    
    it { should render_template 'admin/users/index.html.haml' }
  end
  
  describe :get => :index, :all => true do
    expects :all_order_by, :on => User, :returns => mock_users
    
    it { should render_template 'admin/users/index.html.haml' }
  end
  
  describe :get => :index, :page => 2, :format => 'csv' do
    expects :all, :on => User, :returns => mock_users
  end
  
  # ========
  # = show =
  # ========
  describe :get => :show, :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    
    it { should render_template 'admin/users/show.html.haml' }
  end
  
  # ========
  # = edit =
  # ========
  describe :get => :edit, :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    
    it { should render_template 'admin/users/edit.html.haml' }
  end
  
  # ==========
  # = update =
  # ==========
  describe :put => :update, :id => "1" do # successful
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :update_attributes, :on => mock_user, :returns => true
    
    it { should redirect_to admin_user_path(mock_user) }
  end
  
  describe :put => :update, :id => "1" do # fail
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :update_attributes, :on => mock_user, :returns => false
    
    it { should render_template 'admin/users/edit.html.haml' }
  end
  
  # =========
  # = trash =
  # =========
  describe :put => :trash, :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :update_attributes!, :on => mock_user, :returns => true
    
    it { should redirect_to admin_users_path }
  end
  
  # ===========
  # = destroy =
  # ===========
  describe :delete => :destroy, :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :destroy, :on => mock_user, :returns => true
    
    it { should redirect_to admin_users_path }
  end
  
end