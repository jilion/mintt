require 'spec_helper'

describe ConfirmationsController do
  mock_model :user
  
  # ========
  # = show =
  # ========
  describe :get => :show do
    expects :confirm!, :on => User, :returns => mock_user
    expects :errors, :on => mock_user, :returns => []
    
    it { should redirect_to root_url }
  end
  
end