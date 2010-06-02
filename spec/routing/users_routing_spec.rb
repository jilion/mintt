require 'spec_helper'

describe UsersController do
  
  should_route :get,  '/dashboard', :controller => 'users', :action => :index
  
end