require 'spec_helper'

describe DocumentsController do

  it { should route(:get, "/documents/1").to(:action => :show, :id => 1) }

end
