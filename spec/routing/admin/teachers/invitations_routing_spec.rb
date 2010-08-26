require 'spec_helper'

describe Admin::Teachers::InvitationsController do
  
  it { should route(:get,  "/admin/teachers/invitation/new").to(:action => :new) }
  it { should route(:post, "/admin/teachers/invitation").to(:action => :create) }
  
end