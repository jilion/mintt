require 'spec_helper'

describe MessagesController do

  it "should respond with redirect to GET :new successful" do
    Teacher.stub(:new).and_return(mock_message)
    get :new
    response.should be_success
    response.should render_template('messages/new')
  end

  it "should respond with success to PUT :update successful" do
    Message.stub(:new).and_return(mock_message)
    mock_message.stub(:save).and_return(true)
    post :create, :message => {}
    response.should redirect_to(root_url)
  end

  it "should respond with success to PUT :update unsuccessful" do
    Message.stub(:new).and_return(mock_message)
    mock_message.stub(:save).and_return(false)
    post :create, :message => {}
    response.should be_success
    response.should render_template('messages/new')
  end

end
