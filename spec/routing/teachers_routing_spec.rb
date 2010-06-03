require 'spec_helper'

describe TeachersController do
  
  should_route :get,  '/module', :controller => 'teachers', :action => :index
  
end