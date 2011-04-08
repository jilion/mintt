require 'spec_helper'

describe Devise::SessionsController do

  it { should route(:get,  "/users/login").to(:action => :new) }
  it { should route(:post, "/users/login").to(:action => :create) }
  it { should route(:get,  "/users/logout").to(:action => :destroy) }

  # it { should route(:get,  "/teachers/login").to(:action => :new) }
  # it { should route(:post, "/teachers/login").to(:action => :create) }
  # it { should route(:get,  "/teachers/logout").to(:action => :destroy) }

end
