class Admin::MessagesController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/messages
  def index
    params[:sort_way] ||= 'desc'
    @messages = Message.all_order_by(params.slice(:order_by, :sort_way), { :trashed => false, :page => params[:page] })
  end
  
  # GET /admin/messages/trash
  def trash
    params[:sort_way] ||= 'desc'
    @messages = Message.all_order_by(params.slice(:order_by, :sort_way), { :trashed => true, :page => params[:page] })
    render :index
  end
  
  # GET /admin/messages/:id
  def show
    @message = Message.find(params[:id])
    @message.update_attributes!(:read => true) if @message.unread?
  end
  
  # PUT /admin/messages/:id
  def update
    @message = Message.find(params[:id])
    
    if @message.update_attributes!(:replied => true)
      flash[:success] = 'Message successfully updated'
      redirect_to admin_message_path(@message)
    else
      render :edit
    end
  end
  
  # DELETE /admin/messages/:id
  def destroy
    @message = Message.find(params[:id])
    
    flash[:success] = 'Message successfully trashed' if @message.update_attributes!(:trashed => true)
    redirect_to admin_messages_path
  end
  
private
  
  def ensure_keys_exists
    params[:message].slice(*Message.keys.keys) if params[:message]
  end
  
end