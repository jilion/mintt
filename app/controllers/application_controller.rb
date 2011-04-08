class ApplicationController < ActionController::Base
  include AdminAuthenticatedSystem

  protect_from_forgery

  def after_sign_in_path_for(resource)
    program_path
  end

end
