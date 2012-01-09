require 'spec_helper'

describe Admin::UsersController do

  it "responds with success to GET :index" do
    User.should_receive(:index_order_by).and_return([])

    get :index, :page => 2
    response.should render_template(:index)
  end

  it "responds with success to GET :index with the :csv format" do
    User.should_receive(:index_order_by).with(:all => true, :year => Time.now.utc.year.to_s).and_return([mock_user])
    User.should_receive(:to_csv).and_return("")

    get :index, :format => :csv
    response.should be_success
  end

  it "responds with success to GET :show" do
    User.should_receive(:find).and_return(mock_user)

    get :show, :id => 1
    response.should render_template(:show)
  end

  it "responds with success to GET :edit" do
    User.should_receive(:find).and_return(mock_user)

    get :edit, :id => '1'
    response.should render_template(:edit)
  end

  it "responds with success to PUT :update successful" do
    User.should_receive(:find).and_return(mock_user)
    mock_user.stub(:update_attributes).and_return(true)

    put :update, :id => '1'
    response.should redirect_to(admin_users_path)
  end

  it "responds with success to PUT :update unsuccessful" do
    User.should_receive(:find).and_return(mock_user)
    mock_user.stub(:update_attributes).and_return(false)

    put :update, :id => '1'
    response.should render_template(:edit)
  end

end
