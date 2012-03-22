require 'spec_helper'

describe Teachers::RegistrationsController do

  it { get("/teacher_account/edit").should route_to('teachers/registrations#edit') }
  it { put("/teacher_account").should route_to('teachers/registrations#update') }

end
