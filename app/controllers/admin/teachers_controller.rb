class Admin::TeachersController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/teachers
  def index
    @teachers = Teacher.paginate(:page => params[:page], :per_page => Teacher.per_page)
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  # GET /admin/teachers/:id
  def show
    @teacher = Teacher.find(params[:id])
  end
  
  # GET /admin/teachers/:id/edit
  def edit
    @teacher = Teacher.find(params[:id])
  end
  
  # PUT /admin/teachers/:id
  def update
    @teacher = Teacher.find(params[:id])
    
    if @teacher.update_attributes(params[:teacher])
      flash[:success] = 'Teacher successfully updated'
      redirect_to admin_teacher_path(@teacher)
    else
      render :edit
    end
  end
  
  # DELETE /admin/teachers/:id
  def destroy
    @teacher = Teacher.find(params[:id])
    flash[:success] = 'Teacher successfully destroyed' if @teacher.destroy
    redirect_to admin_teachers_path
  end
  
end
