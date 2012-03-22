require 'spec_helper'

describe ProgramsController do

  it { get("/schedule").should route_to('programs#index') }

end
