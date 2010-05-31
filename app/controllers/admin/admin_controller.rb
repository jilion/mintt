class Admin::AdminController < ApplicationController
  before_filter :admin_required
  
  ssl_required
  
  layout 'admin'
  
private
  
  def ssl_required?
    true
  end
  
end