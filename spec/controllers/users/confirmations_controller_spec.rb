require 'spec_helper'

describe Users::ConfirmationsController do
  let(:user) { create(:user) }

  it "responds with redirect to GET :show" do
    request.env['devise.mapping'] = Devise.mappings[:user]
    User.stub(:confirm_by_token).with("1234").and_return(user)
    user.stub_chain(:errors, :empty?).and_return(true)

    get :show, :confirmation_token => "1234"
    response.should redirect_to(root_url)
  end

end
