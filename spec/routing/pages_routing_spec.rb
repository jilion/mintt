require 'spec_helper'

describe PagesController do
  
  should_route :get, '/',        :controller => 'pages',  :action => :show, :id => 'home'
  should_route :get, '/modules', :controller => 'pages', :action => :show,  :id => 'modules'
  
end