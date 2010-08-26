require 'spec_helper'

describe PagesController do
  
  it { should route(:get, "/").to(:action => :show, :id => 'home') }
  it { should route(:get, "/modules").to(:action => :show, :id => 'modules') }
  
end