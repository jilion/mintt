require 'spec_helper'

describe Admin::DocumentsController do

  it "should respond with success to GET :index" do
    Document.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should be_success
  end

  it "should respond with success to GET :show" do
    Document.stub(:find).and_return(mock_document)
    get :show, :id => 1
    response.should be_success
  end

  it "should respond with success to GET :new" do
    Document.stub(:new).and_return(mock_document)
    get :new
    response.should be_success
  end

  it "should respond with success to POST :create" do
    Document.stub(:new).and_return(mock_document)
    mock_document.stub(:save).and_return(true)
    post :create
    response.should redirect_to(admin_document_path(mock_document))
  end

  it "should respond with success to GET :edit" do
    Document.stub(:find).and_return(mock_document)
    get :edit, :id => '1'
    response.should be_success
  end

  it "should respond with success to PUT :update successful" do
    Document.stub(:find).and_return(mock_document)
    mock_document.stub(:update_attributes).and_return(true)
    put :update, :id => '1'
    response.should redirect_to(admin_document_path(mock_document))
  end

  it "should respond with success to PUT :update unsuccessful" do
    Document.stub(:find).and_return(mock_document)
    mock_document.stub(:update_attributes).and_return(false)
    put :update, :id => '1'
    response.should be_success
  end

  it "should respond with success to DELETE :destroy" do
    Document.stub(:find).and_return(mock_document)
    mock_document.stub(:destroy).and_return(true)
    delete :destroy, :id => '1'
    response.should redirect_to(admin_documents_path)
  end

end
