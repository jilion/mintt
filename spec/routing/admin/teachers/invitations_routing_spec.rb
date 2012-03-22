require 'spec_helper'

describe Admin::Teachers::InvitationsController do

  it { get("/admin/teachers/invitation/new").should route_to('admin/teachers/invitations#new') }
  it { post("/admin/teachers/invitation").should route_to('admin/teachers/invitations#create') }

end
