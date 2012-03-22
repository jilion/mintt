require 'spec_helper'

describe Admin::MessagesController do

  it { get("/admin/messages/inbox").should route_to('admin/messages#index') }
  it { get("/admin/messages/trash").should route_to('admin/messages#index', :trashed => true) }
  it { get("/admin/messages/1").should route_to('admin/messages#show', :id => '1') }
  it { put("/admin/messages/1").should route_to('admin/messages#update', :id => '1') }

end
