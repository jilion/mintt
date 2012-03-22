require 'spec_helper'

describe Admin::UsersController do

  it { get("/admin/users").should route_to('admin/users#index') }
  it { get("/admin/users/1").should route_to('admin/users#show', :id => '1') }
  it { get("/admin/users/1/edit").should route_to('admin/users#edit', :id => '1') }
  it { put("/admin/users/1").should route_to('admin/users#update', :id => '1') }

end
