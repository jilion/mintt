require 'spec_helper'

describe Devise::SessionsController do

  it { get("/users/login").should route_to('devise/sessions#new') }
  it { post("/users/login").should route_to('devise/sessions#create') }
  it { get("/users/logout").should route_to('devise/sessions#destroy') }

  it { get("/teachers/login").should route_to('devise/sessions#new') }
  it { post("/teachers/login").should route_to('devise/sessions#create') }
  it { get("/teachers/logout").should route_to('devise/sessions#destroy') }

end
