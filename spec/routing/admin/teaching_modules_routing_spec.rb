require 'spec_helper'

describe Admin::TeachingModulesController do

  it { should route(:get,    "/admin/modules").to(:action => :index) }
  it { should route(:get,    "/admin/modules/1").to(:action => :show,      :id => '1') }
  it { should route(:get,    "/admin/modules/new").to(:action => :new) }
  it { should route(:post,   "/admin/modules").to(:action => :create) }
  it { should route(:get,    "/admin/modules/1/edit").to(:action => :edit, :id => '1') }
  it { should route(:put,    "/admin/modules/1").to(:action => :update,    :id => '1') }
  it { should route(:delete, "/admin/modules/1").to(:action => :destroy,   :id => '1') }

end
