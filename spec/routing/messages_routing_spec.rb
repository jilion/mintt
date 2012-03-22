require 'spec_helper'

describe MessagesController do

  it { get("/contact").should route_to('messages#new') }
  it { post("/contact").should route_to('messages#create') }

end
