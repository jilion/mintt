require 'spec_helper'

describe RegistrationsController do
  mock_model :user
  
  describe :post => :create, :user => Factory.attributes_for(:user).merge({ :not_registered_key => 'foo' }) do
    expects :new, :on => User, :returns => mock_user
    expects :save, :on => mock_user, :returns => true
    
    it { params.include?(:not_registered_key).should_not be_true }
    it { should redirect_to root_url }
  end
  
  describe :post => :create, :user => {} do
    expects :new, :on => User, :returns => mock_user
    expects :save, :on => mock_user, :returns => false
    
    it { should render_template 'registrations/new' }
  end
  
end