require 'spec_helper'

describe ProgramsController do
  
  should_route :get,  '/program', :controller => 'programs', :action => :index
  
end