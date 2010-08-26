require 'spec_helper'

describe Admin::TeachersController do
  
  it "should respond with success to GET :index" do
    Teacher.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should be_success
  end
  
  it "should respond with success to GET :show" do
    Teacher.stub(:find).and_return(mock_teacher)
    get :show, :id => 1
    response.should be_success
  end
  
  it "should respond with success to GET :edit" do
    Teacher.stub(:find).and_return(mock_teacher)
    get :edit, :id => '1'
    response.should be_success
  end
  
  it "should respond with success to PUT :update successful" do
    Teacher.stub(:find).and_return(mock_teacher)
    mock_teacher.stub(:update_attributes).and_return(true)
    put :update, :id => '1'
    response.should redirect_to(admin_teachers_path)
  end
  
  it "should respond with success to PUT :update unsuccessful" do
    Teacher.stub(:find).and_return(mock_teacher)
    mock_teacher.stub(:update_attributes).and_return(false)
    put :update, :id => '1'
    response.should be_success
  end
  
  it "should respond with success to DELETE :destroy" do
    Teacher.stub(:find).and_return(mock_teacher)
    mock_teacher.stub(:destroy).and_return(true)
    delete :destroy, :id => '1'
    response.should redirect_to(admin_teachers_path)
  end
  
private
  
  def mock_teacher(stubs={})
    @mock_teacher ||= mock_model(Teacher, stubs)
  end
  
end