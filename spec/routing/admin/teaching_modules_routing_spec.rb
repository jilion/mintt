require 'spec_helper'

describe Admin::TeachingModulesController do

  it { get("/admin/modules").should route_to('admin/teaching_modules#index') }
  it { get("/admin/modules/1").should route_to('admin/teaching_modules#show', :id => '1') }
  it { get("/admin/modules/new").should route_to('admin/teaching_modules#new') }
  it { post("/admin/modules").should route_to('admin/teaching_modules#create') }
  it { get("/admin/modules/1/edit").should route_to('admin/teaching_modules#edit', :id => '1') }
  it { put("/admin/modules/1").should route_to('admin/teaching_modules#update', :id => '1') }
  it { delete("/admin/modules/1").should route_to('admin/teaching_modules#destroy', :id => '1') }

end
