require 'spec_helper'

describe Admin::TeachersController do

  it "responds with success to GET :index" do
    Teacher.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should render_template(:index)
  end

  it "responds with success to GET :show" do
    Teacher.stub(:find).and_return(mock_teacher)
    get :show, :id => 1
    response.should render_template(:show)
  end

  it "responds with success to GET :edit" do
    Teacher.stub(:find).and_return(mock_teacher)
    get :edit, :id => '1'
    response.should render_template(:edit)
  end

  it "responds with success to PUT :update successful" do
    Teacher.stub(:find).and_return(mock_teacher)
    mock_teacher.stub(:update_attributes).and_return(true)
    put :update, :id => '1'
    response.should redirect_to(admin_teachers_path)
  end

  it "responds with success to PUT :update unsuccessful" do
    Teacher.stub(:find).and_return(mock_teacher)
    mock_teacher.stub(:update_attributes).and_return(false)
    put :update, :id => '1'
    response.should render_template(:edit)
  end

  it "responds with success to DELETE :destroy" do
    Teacher.stub(:find).and_return(mock_teacher)
    mock_teacher.stub(:destroy).and_return(true)
    delete :destroy, :id => '1'
    response.should redirect_to(admin_teachers_path)
  end

end
