require 'spec_helper'

describe Users::ConfirmationsController do

  it { get("/users/confirm").should route_to('users/confirmations#show') }

end
