require 'spec_helper'

describe ConfirmationsController do
  
  should_route :get,  '/users/confirmation', :controller => 'confirmations', :action => :show
  
end