require 'spec_helper'

describe RegistrationsController do
  mock_model :user
  
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