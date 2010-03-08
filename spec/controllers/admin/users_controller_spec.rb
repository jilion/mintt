require 'spec_helper'

describe Admin::UsersController do
  mock_model :user
  
  describe :get => :index, :user => Factory.attributes_for(:user) do
    expects :all_order_by, :on => User, :returns => mock_users
    
    it { should render_template 'admin/users/index' }
  end
  
  describe :get => :show, :user => Factory.attributes_for(:user), :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    
    it { should render_template 'admin/users/show' }
  end
  
  describe :get => :edit, :user => Factory.attributes_for(:user), :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    
    it { should render_template 'admin/users/edit' }
  end
  
  describe :put => :update, :user => Factory.attributes_for(:user).merge({:not_registered_key => 'foo'}), :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :update_attributes, :on => mock_user, :returns => true
    
    it { params.include?(:not_registered_key).should_not be_true }
    it { should redirect_to admin_user_path(mock_user) }
  end
  
  describe :put => :update, :user => {}, :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :update_attributes, :on => mock_user, :returns => false
    
    it { should render_template 'admin/users/edit' }
  end
  
  describe :delete => :destroy, :user => Factory.attributes_for(:user), :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :destroy, :on => mock_user, :returns => true
    
    it { should redirect_to admin_users_path }
  end
  
end