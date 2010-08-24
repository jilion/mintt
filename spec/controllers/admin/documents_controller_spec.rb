require 'spec_helper'

describe Admin::DocumentsController do
  # mock_model :document
  
  it "should respond with success to GET :index", :focus => true do
    Document.stub(:all).and_return([])
    get :index, :page => 2
    response.should be_success
    # expects :all, :on => Document, :returns => mock_documents
    # it { should render_template 'admin/documents/index.html.haml' }
  end
  
  # # ========
  # # = show =
  # # ========
  # describe :get => :show, :id => "1" do
  #   expects :find, :on => Document, :with => "1", :returns => mock_document
  #   
  #   it { should render_template 'admin/documents/show.html.haml' }
  # end
  # 
  # # ========
  # # = edit =
  # # ========
  # describe :get => :edit, :id => "1" do
  #   expects :find, :on => Document, :with => "1", :returns => mock_document
  #   
  #   it { should render_template 'admin/documents/edit.html.haml' }
  # end
  # 
  # # ==========
  # # = update =
  # # ==========
  # describe :put => :update, :id => "1" do
  #   expects :find, :on => Document, :with => "1", :returns => mock_document
  #   expects :update_attributes, :on => mock_document, :returns => true
  #   
  #   it { should redirect_to admin_document_path(mock_document) }
  # end
  # 
  # describe :put => :update, :id => "1" do
  #   expects :find, :on => Document, :with => "1", :returns => mock_document
  #   expects :update_attributes, :on => mock_document, :returns => false
  #   
  #   it { should render_template 'admin/documents/edit.html.haml' }
  # end
  # 
  # # ===========
  # # = destroy =
  # # ===========
  # describe :delete => :destroy, :id => "1" do
  #   expects :find, :on => Document, :with => "1", :returns => mock_document
  #   expects :destroy, :on => mock_document, :returns => true
  #   
  #   it { should redirect_to admin_documents_path }
  # end
  
end