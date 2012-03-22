class ApplicationController < ActionController::Base
  include AdminAuthenticatedSystem
  include CustomDevisePaths

  protect_from_forgery

  module DeviseInvitable::Controllers::Helpers
    protected
    def authenticate_inviter!
      # do nothing
    end
  end

end
