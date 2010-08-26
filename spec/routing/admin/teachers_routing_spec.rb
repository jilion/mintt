require 'spec_helper'

describe Admin::TeachersController do
  
  it { should route(:get,    "/admin/teachers").to(:action => :index) }
  it { should route(:get,    "/admin/teachers/1").to(:action => :show,      :id => '1') }
  it { should route(:get,    "/admin/teachers/1/edit").to(:action => :edit, :id => '1') }
  it { should route(:put,    "/admin/teachers/1").to(:action => :update,    :id => '1') }
  it { should route(:delete, "/admin/teachers/1").to(:action => :destroy,   :id => '1') }
  
end