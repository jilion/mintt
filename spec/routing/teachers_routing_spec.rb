require 'spec_helper'

describe TeachersController do
  
  should_route :get,  '/lobby', :controller => 'teachers', :action => :index
  
end