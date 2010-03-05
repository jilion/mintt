class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  include AdminAuthenticatedSystem
  
  before_filter :admin_required # remove for production
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def default_url_options(options = {})
    { :host => Rails.env.production? ? MINTT_EPFL : MINTT_LOCAL }
  end
  
end