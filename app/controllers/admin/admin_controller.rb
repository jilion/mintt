class Admin::AdminController < ApplicationController
  before_filter :admin_required
  
  ssl_required
  
  layout 'admin'
  
  # GET /admin
  def index
    redirect_to admin_users_path
  end
  
  private
  
  def ssl_required?
    true
  end
  
end