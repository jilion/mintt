require 'spec_helper'

describe Users::ApplicationsController do
  
  it { should route(:get,  "/apply").to(:action => :new) }
  it { should route(:post, "/apply").to(:action => :create) }
  
end