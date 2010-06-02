require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers
  
  # =======
  # = get =
  # =======
  describe :get => :index do
    before(:each) do
      @user = Factory(:user)
      @user.confirm!
      sign_in @user
    end
    
    it { should render_template 'users/index.html.haml' }
  end
  
end