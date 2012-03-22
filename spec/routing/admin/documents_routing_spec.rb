require 'spec_helper'

describe Admin::DocumentsController do

  it { get("/admin/documents").should route_to('admin/documents#index') }
  it { get("/admin/documents/1").should route_to('admin/documents#show', :id => '1') }
  it { get("/admin/documents/new").should route_to('admin/documents#new') }
  it { post("/admin/documents").should route_to('admin/documents#create') }
  it { get("/admin/documents/1/edit").should route_to('admin/documents#edit', :id => '1') }
  it { post("/admin/documents/modules").should route_to('admin/documents#modules') }
  it { put("/admin/documents/1").should route_to('admin/documents#update', :id => '1') }
  it { delete("/admin/documents/1").should route_to('admin/documents#destroy', :id => '1') }

end
