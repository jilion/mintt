require 'spec_helper'

describe Admin::DocumentsController do
  
  it { should route(:get,    "/admin/documents").to(:action => :index) }
  it { should route(:get,    "/admin/documents/1").to(:action => :show,      :id => '1') }
  it { should route(:get,    "/admin/documents/new").to(:action => :new) }
  it { should route(:post,   "/admin/documents").to(:action => :create) }
  it { should route(:get,    "/admin/documents/1/edit").to(:action => :edit, :id => '1') }
  it { should route(:put,    "/admin/documents/1").to(:action => :update,    :id => '1') }
  it { should route(:delete, "/admin/documents/1").to(:action => :destroy,   :id => '1') }
  
end