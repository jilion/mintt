class Admin::TeachingModulesController < Admin::AdminController
  before_filter :set_year, :only => :index

  # GET /admin/modules
  def index
    @teaching_modules = TeachingModule.index_order_by(params.merge(:year => session[:admin_year]))
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /admin/modules/:id
  def show
    @teaching_module = TeachingModule.find(params[:id])
  end

  # GET /admin/modules/new
  def new
    @teaching_module = TeachingModule.new
  end

  # POST /admin/modules/:id
  def create
    @teaching_module = TeachingModule.new(params[:teaching_module])

    respond_to do |format|
      if @teaching_module.update_attributes(params[:teaching_module])
        format.html { redirect_to [:admin, :teaching_modules], :notice => "Module successfully created." }
      else
        render :new
      end
    end

  end

  # GET /admin/modules/:id/edit
  def edit
    @teaching_module = TeachingModule.find(params[:id])
  end

  # PUT /admin/modules/:id
  def update
    @teaching_module = TeachingModule.find(params[:id])

    respond_to do |format|
      if @teaching_module.update_attributes(params[:teaching_module])
        format.html { redirect_to [:admin, :teaching_modules], :notice => "Module successfully updated." }
      else
        render :edit
      end
    end
  end

  # DELETE /admin/modules/:id
  def destroy
    @teaching_module = TeachingModule.find(params[:id])
    flash[:notice] = 'Module successfully destroyed' if @teaching_module.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, :teaching_modules] }
    end
  end

end
