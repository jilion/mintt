class Admin::AdminController < ApplicationController
  before_filter :admin_required
  layout 'admin'
  
  # ssl_required
#   
#   
# private
#   
#   def ssl_required?
#     true
#   end
  
end