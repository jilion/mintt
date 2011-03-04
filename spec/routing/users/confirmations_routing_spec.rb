require 'spec_helper'

describe Users::ConfirmationsController do

  it { should route(:get, "/users/confirm").to(:action => :show) }

end
