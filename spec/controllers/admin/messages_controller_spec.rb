require 'spec_helper'

describe Admin::MessagesController do

  it "responds with success to GET :index" do
    Message.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should render_template(:index)
  end

  it "responds with success to GET :show" do
    Message.stub(:find).and_return(mock_message)
    mock_message.stub(:unread?).and_return(false)
    get :show, :id => 1
    response.should render_template(:show)
  end

  it "responds with success to PUT :update and redirect to inbox if message is not trashed" do
    Message.stub(:find).and_return(mock_message)
    mock_message.stub(:update_attributes).and_return(true)
    mock_message.stub(:trashed?).and_return(false)
    put :update, :id => '1'
    response.should redirect_to(admin_messages_path)
  end

  it "responds with success to PUT :update and redirect to trash if message is trashed" do
    Message.stub(:find).and_return(mock_message)
    mock_message.stub(:update_attributes).and_return(true)
    mock_message.stub(:trashed?).and_return(true)
    put :update, :id => '1'
    response.should redirect_to(admin_messages_path(:trashed => true))
  end

end
