class Admin::TeachersController < Admin::AdminController
  
  # GET /admin/teachers
  def index
    @teachers = Teacher.index_order_by(params)
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
      redirect_to admin_teachers_path, :notice => "Teacher successfully updated."
    else
      render :edit
    end
  end
  
  # DELETE /admin/teachers/:id
  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to admin_teachers_path, :notice => "Teacher successfully destroyed."
  end
  
end
