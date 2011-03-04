require 'spec_helper'

describe SessionsController do
  include Devise::TestHelpers

  it "should respond with redirect to POST :create" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    warden.stub(:authenticate!).and_return(mock_user)
    mock_user.stub(:selected?).and_return(true)
    post :create, :user => {}
    response.should redirect_to(program_url)
  end

end
