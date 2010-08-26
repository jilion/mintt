require 'spec_helper'

describe Users::ConfirmationsController do
  
  it "should respond with redirect to GET :show" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    User.stub(:confirm!).and_return(mock_user)
    mock_user.stub_chain(:errors, :empty?).and_return(true)
    get :show, :confirmation_token => "1234"
    response.should redirect_to(root_url)
  end
  
private
  
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  
end