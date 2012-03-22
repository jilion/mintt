require 'spec_helper'

describe PagesController do

  it { get("/").should route_to('pages#show', :id => 'home') }
  it { get("/modules").should route_to('pages#show', :id => 'modules') }

end
