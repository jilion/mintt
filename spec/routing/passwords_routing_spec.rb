require 'spec_helper'

describe PasswordsController do
  
  should_route :get,  '/users/password/new',  :controller => 'passwords', :action => :new
  should_route :post, '/users/password',      :controller => 'passwords', :action => :create
  should_route :get,  '/users/password/edit', :controller => 'passwords', :action => :edit
  should_route :put,  '/users/password',      :controller => 'passwords', :action => :update
  
end