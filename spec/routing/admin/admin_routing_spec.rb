require 'spec_helper'

describe Admin::AdminController do
  
  should_route :get,  '/admin', :controller => 'admin/users', :action => :index
  
end