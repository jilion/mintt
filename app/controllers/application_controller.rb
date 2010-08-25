class ApplicationController < ActionController::Base
  include CustomDevisePaths
  include AdminAuthenticatedSystem
  
  protect_from_forgery
  
protected
  
  module DeviseInvitable::Controllers::Helpers
  protected
    def authenticate_inviter!
    end
  end
  
end