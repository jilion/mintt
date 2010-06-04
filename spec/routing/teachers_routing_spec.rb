require 'spec_helper'

describe TeachersController do
  
  should_route :get,  '/program', :controller => 'programs', :action => :index
  
end