require 'spec_helper'

describe UsersController do
  
  should_route :get,  '/program', :controller => 'programs', :action => :index
  
end