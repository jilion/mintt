require 'spec_helper'

describe ProgramsController do
  
  it { should route(:get, "/program").to(:action => :index) }
  
end