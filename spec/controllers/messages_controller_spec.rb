require 'spec_helper'

describe MessagesController do

  it "responds with redirect to GET :new successful" do
    Teacher.stub(:new).and_return(mock_message)
    get :new
    response.should render_template(:new)
  end

  it "responds with success to PUT :update successful" do
    Message.stub(:new).and_return(mock_message)
    mock_message.stub(:save).and_return(true)
    post :create, :message => {}
    response.should redirect_to(root_url)
  end

  it "responds with success to PUT :update unsuccessful" do
    Message.stub(:new).and_return(mock_message)
    mock_message.stub(:save).and_return(false)
    post :create, :message => {}
    response.should render_template(:new)
  end

end
