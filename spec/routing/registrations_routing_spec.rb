require 'spec_helper'

describe RegistrationsController do
  
  should_route :get,  '/users/apply', :controller => 'registrations', :action => :new
  should_route :post, '/users',       :controller => 'registrations', :action => :create
  should_route :get,  '/users/edit',  :controller => 'registrations', :action => :edit
  should_route :put,  '/users',       :controller => 'registrations', :action => :update
  
end