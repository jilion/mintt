require 'spec_helper'

describe InvitationsController do
  
  should_route :get,  '/teachers/invitation/new',    :controller => 'invitations', :action => :new
  should_route :post, '/teachers/invitation',        :controller => 'invitations', :action => :create
  should_route :get,  '/teachers/invitation/accept', :controller => 'invitations', :action => :edit
  should_route :put,  '/teachers/invitation',        :controller => 'invitations', :action => :update
  
end