class Admin::DocumentsController < Admin::AdminController
  respond_to :html
  respond_to :js, :only => [:index, :modules]

  before_filter :set_year, :only => :index

  # GET /admin/documents
  def index
    @documents = Document.index_order_by(params.merge(:year => session[:admin_year]))

    respond_with(@documents)
  end

  # GET /admin/documents/:id
  def show
    @document = Document.find(params[:id])

    respond_with(@document)
  end

  # GET /admin/documents/new
  def new
    @document = Document.new

    respond_with(@document)
  end

  # POST /admin/documents/:id
  def create
    @document = Document.new(params[:document])

    respond_with(@document) do |format|
      if @document.save
        format.html { redirect_to [:admin, :documents], :notice => "Document successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # GET /admin/documents/:id/edit
  def edit
    @document = Document.find(params[:id])

    respond_with(@document)
  end

  def modules
    @document = Document.new(params[:document])

    respond_with(@document)
  end

  # PUT /admin/documents/:id
  def update
    @document = Document.find(params[:id])

    respond_with(@document) do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to [:admin, :documents], :notice => "Document successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/documents/:id
  def destroy
    @document = Document.find(params[:id])
    flash[:notice] = 'Document successfully destroyed' if @document.destroy

    respond_with(@document, :location => [:admin, :documents])
  end

end
