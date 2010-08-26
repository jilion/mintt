require 'spec_helper'

describe Admin::UsersController do
  
  it "should respond with success to GET :index" do
    User.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should be_success
  end
  
  it "should respond with success to GET :index" do
    User.stub(:index_order_by).with(:all => true).and_return([])
    get :index, :format => :csv
    response.should be_success
  end
  
  it "should respond with success to GET :show" do
    User.stub(:find).and_return(mock_user)
    get :show, :id => 1
    response.should be_success
  end
  
  it "should respond with success to GET :edit" do
    User.stub(:find).and_return(mock_user)
    get :edit, :id => '1'
    response.should be_success
  end
  
  it "should respond with success to PUT :update successful" do
    User.stub(:find).and_return(mock_user)
    mock_user.stub(:update_attributes).and_return(true)
    put :update, :id => '1'
    response.should redirect_to(admin_users_path)
  end
  
  it "should respond with success to PUT :update unsuccessful" do
    User.stub(:find).and_return(mock_user)
    mock_user.stub(:update_attributes).and_return(false)
    put :update, :id => '1'
    response.should be_success
  end
  
private
  
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  
end