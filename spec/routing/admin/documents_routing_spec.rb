require 'spec_helper'

describe Admin::DocumentsController do
  
  should_route :get,    '/admin/documents',        :controller => 'admin/documents', :action => :index
  should_route :get,    '/admin/documents/new',    :controller => 'admin/documents', :action => :new
  should_route :post,   '/admin/documents',        :controller => 'admin/documents', :action => :create
  should_route :get,    '/admin/documents/1/edit', :controller => 'admin/documents', :action => :edit,    :id => '1'
  should_route :put,    '/admin/documents/1',      :controller => 'admin/documents', :action => :update,  :id => '1'
  should_route :delete, '/admin/documents/1',      :controller => 'admin/documents', :action => :destroy, :id => '1'
  
end