require 'spec_helper'

describe MessagesController do
  
  should_route :get,  '/contact',     :controller => 'messages', :action => :new
  should_route :post, '/contact',     :controller => 'messages', :action => :create
  
end