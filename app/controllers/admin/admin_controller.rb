class Admin::AdminController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  
  # GET /admin
  def index
    redirect_to :controller => 'admin/users'
  end
  
end