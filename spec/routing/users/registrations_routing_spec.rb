require 'spec_helper'

describe Users::RegistrationsController do

  it { get("/apply").should route_to('users/registrations#new') }
  it { post("/apply").should route_to('users/registrations#create') }

end
