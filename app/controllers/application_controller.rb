class ApplicationController < ActionController::Base
  include SslRequirement
  include AdminAuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  skip_before_filter :ensure_proper_protocol unless Rails.env.production?
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  def default_url_options(options = {})
    { :host => Rails.env.production? ? MINTT_EPFL : MINTT_LOCAL }
  end
  
  def after_update_path_for(resource_or_scope)
    send "edit_#{resource_or_scope.class.to_s.underscore}_registration_path"
  end
  
protected
  
  def ensure_keys_exists
    object_name = controller_name.singularize.to_sym
    params[object_name].slice(*controller_name.classify.constantize.keys.keys) if params[object_name]
  end
  
end