class Admin::TeachersController < Admin::AdminController
  respond_to :html
  respond_to :js, :only => [:index]

  before_filter :set_year, :only => [:index]

  # GET /admin/teachers
  def index
    @teachers = Teacher.index_order_by(params.merge(:year => session[:admin_year]))
    @teachers_not_active = Teacher.index_order_by(params.merge(:not_year => session[:admin_year]))

    respond_with(@teachers)
  end

  # GET /admin/teachers/:id
  def show
    @teacher = Teacher.find(params[:id])

    respond_with(@teacher)
  end

  # GET /admin/teachers/:id/edit
  def edit
    @teacher = Teacher.find(params[:id])

    respond_with(@teacher)
  end

  # PUT /admin/teachers/:id
  def update
    @teacher = Teacher.find(params[:id])

    respond_with(@teacher) do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to [:admin, :teachers], :notice => "Teacher successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/teachers/:id
  def destroy
    @teacher = Teacher.find(params[:id])
    flash[:notice] = 'Teacher successfully destroyed' if @teacher.destroy

    respond_with(@teacher, :location => [:admin, :teachers])
  end

end
