class Admin::DocumentsController < Admin::AdminController
  
  # GET /admin/documents
  def index
    @documents = Document.index_order_by(params)
    respond_to do |format|
      format.js
      format.html
    end
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
      redirect_to admin_document_path(@document), :notice => "Document successfully created."
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
      redirect_to admin_document_path(@document), :notice => "Document successfully updated."
    else
      render :edit
    end
  end
  
  # DELETE /admin/documents/:id
  def destroy
    @document = Document.find(params[:id])
    flash[:notice] = 'Document successfully destroyed' if @document.destroy
    redirect_to admin_documents_path
  end
  
end