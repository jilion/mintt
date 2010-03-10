require 'spec_helper'

describe Admin::AdminController do
  
  # =========
  # = index =
  # =========
  describe :get => :index do
    it { should redirect_to admin_users_path }
  end
  
end