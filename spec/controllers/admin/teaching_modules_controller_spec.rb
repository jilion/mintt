require 'spec_helper'

describe Admin::TeachingModulesController do

  it "should respond with success to GET :index" do
    TeachingModule.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should be_success
  end

  it "should respond with success to GET :show" do
    TeachingModule.stub(:find).and_return(mock_teaching_module)
    get :show, :id => 1
    response.should be_success
  end

  it "should respond with success to GET :edit" do
    TeachingModule.stub(:find).and_return(mock_teaching_module)
    get :edit, :id => '1'
    response.should be_success
  end

  it "should respond with success to PUT :update successful" do
    TeachingModule.stub(:find).and_return(mock_teaching_module)
    mock_teaching_module.stub(:update_attributes).and_return(true)
    put :update, :id => '1'
    response.should redirect_to([:admin, :teaching_modules])
  end

  it "should respond with success to PUT :update unsuccessful" do
    TeachingModule.stub(:find).and_return(mock_teaching_module)
    mock_teaching_module.stub(:update_attributes).and_return(false)
    put :update, :id => '1'
    response.should render_template('edit')
  end

  it "should respond with success to DELETE :destroy" do
    TeachingModule.stub(:find).and_return(mock_teaching_module)
    mock_teaching_module.stub(:destroy).and_return(true)
    delete :destroy, :id => '1'
    response.should redirect_to([:admin, :teaching_modules])
  end

end
