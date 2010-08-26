require 'spec_helper'

describe TeachersController do
  
  it { should route(:put, "/teachers").to(:action => :update) }
  
end