require 'spec_helper'

describe DocumentsController do

  it { get("/documents/1").should route_to('documents#show', :id => '1') }

end
