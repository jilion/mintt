class ApplicationController < ActionController::Base
  include CustomDevisePaths
  include AdminAuthenticatedSystem
  
  protect_from_forgery
  
protected
  
  def ensure_keys_exists
    object_name = controller_name.singularize.to_sym
    params[object_name].slice(*controller_name.classify.constantize.fields.keys) if params[object_name]
  end
  
  module DeviseInvitable::Controllers::Helpers
  protected
    def authenticate_inviter!
      #authenticate_admin!
    end
  end
  
end