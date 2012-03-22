require 'spec_helper'

describe Admin::TeachersController do

  it { get("/admin/teachers").should route_to('admin/teachers#index') }
  it { get("/admin/teachers/1").should route_to('admin/teachers#show', :id => '1') }
  it { get("/admin/teachers/1/edit").should route_to('admin/teachers#edit', :id => '1') }
  it { put("/admin/teachers/1").should route_to('admin/teachers#update', :id => '1') }
  it { delete("/admin/teachers/1").should route_to('admin/teachers#destroy', :id => '1') }

end
