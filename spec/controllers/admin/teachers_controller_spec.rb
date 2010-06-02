require 'spec_helper'

describe Admin::TeachersController do
  mock_model :teacher
  
  # =========
  # = index =
  # =========
  describe :get => :index do
    expects :paginate, :on => Teacher, :returns => mock_teachers
    
    it { should render_template 'admin/teachers/index.html.haml' }
  end
  
  # ========
  # = show =
  # ========
  describe :get => :show, :id => "1" do
    expects :find, :on => Teacher, :with => "1", :returns => mock_teacher
    
    it { should render_template 'admin/teachers/show.html.haml' }
  end
  
  # ========
  # = edit =
  # ========
  describe :get => :edit, :id => "1" do
    expects :find, :on => Teacher, :with => "1", :returns => mock_teacher
    
    it { should render_template 'admin/teachers/edit.html.haml' }
  end
  
  # ==========
  # = update =
  # ==========
  describe :put => :update, :id => "1" do
    expects :find, :on => Teacher, :with => "1", :returns => mock_teacher
    expects :update_attributes, :on => mock_teacher, :returns => true
    
    it { should redirect_to admin_teacher_path(mock_teacher) }
  end
  
  describe :put => :update, :id => "1" do
    expects :find, :on => Teacher, :with => "1", :returns => mock_teacher
    expects :update_attributes, :on => mock_teacher, :returns => false
    
    it { should render_template 'admin/teachers/edit.html.haml' }
  end
  
  # ===========
  # = destroy =
  # ===========
  describe :delete => :destroy, :id => "1" do
    expects :find, :on => Teacher, :with => "1", :returns => mock_teacher
    expects :destroy, :on => mock_teacher, :returns => true
    
    it { should redirect_to admin_teachers_path }
  end
  
end