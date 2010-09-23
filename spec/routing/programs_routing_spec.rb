require 'spec_helper'

describe ProgramsController do
  
  it { should route(:get, "/schedule").to(:action => :index) }
  
end