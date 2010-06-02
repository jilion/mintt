require 'spec_helper'

describe SessionsController do
  
  should_route :get,  '/users/login',  :controller => 'sessions', :action => :new
  should_route :post, '/users/login',  :controller => 'sessions', :action => :create
  should_route :get,  '/users/logout', :controller => 'sessions', :action => :destroy
  
end