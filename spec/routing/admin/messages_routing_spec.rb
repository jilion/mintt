require 'spec_helper'

describe Admin::MessagesController do
  
  it { should route(:get, "/admin/messages").to(:action => :index) }
  it { should route(:get, "/admin/messages/1").to(:action => :show,      :id => '1') }
  it { should route(:put, "/admin/messages/1").to(:action => :update,    :id => '1') }
  
end