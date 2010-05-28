require 'spec_helper'

describe RegistrationsController do
  mock_model :user
  
  # ==========
  # = create =
  # ==========
  describe :post => :create do
    if REGISTRATION_OPEN
      expects :new, :on => User, :returns => mock_user
      expects :save, :on => mock_user, :returns => true
    end
    
    it { should redirect_to root_url }
  end
  
  describe :post => :create do
    if REGISTRATION_OPEN
      expects :new, :on => User, :returns => mock_user
      expects :save, :on => mock_user, :returns => false
      
      it { should render_template 'registrations/new.html.haml' }
    else
      it { should redirect_to root_url }
    end
  end
  
end