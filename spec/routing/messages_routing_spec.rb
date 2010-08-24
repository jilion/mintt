require 'spec_helper'

describe MessagesController do
  
  it { should route(:get, "contact").to(:action => :new) }
  it { should route(:post, "contact").to(:action => :create) }
  
end