class Admin::DocumentsController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/documents
  def index
    @documents = Document.all
  end
  
  # GET /admin/documents/:id
  def show
    @document = Document.find(params[:id])
  end
  
  # GET /admin/documents/new
  def new
    @document = Document.new
  end
  
  # POST /admin/documents/:id
  def create
    @document = Document.new(params[:document])
    
    if @document.save
      flash[:success] = 'Document successfully created'
      redirect_to admin_document_path(@document)
    else
      render :new
    end
  end
  
  # GET /admin/documents/:id/edit
  def edit
    @document = Document.find(params[:id])
  end
  
  # PUT /admin/documents/:id
  def update
    @document = Document.find(params[:id])
    
    if @document.update_attributes(params[:document])
      flash[:success] = 'Document successfully updated'
      redirect_to admin_document_path(@document)
    else
      render :edit
    end
  end
  
  # DELETE /admin/documents/:id
  def destroy
    @document = Document.find(params[:id])
    flash[:success] = 'Document successfully destroyed' if @document.destroy
    redirect_to admin_documents_path
  end
  
end