require 'spec_helper'

describe Admin::UsersController do
  mock_model :user
  
  describe :put => :update, :user => Factory.attributes_for(:user).merge({:not_registered_key => 'foo'}), :id => "1" do
    expects :find, :on => User, :with => "1", :returns => mock_user
    expects :update_attributes, :on => mock_user, :returns => true
    
    it { should redirect_to admin_users_path }
    it { params.include?(:not_registered_key).should_not be_true }
  end
  
end