class Admin::MessagesController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/messages
  def index
    @messages = Message.index_order_by(params)
    render :index
  end
  
  # GET /admin/messages/trashes
  def trashes
    @messages = Message.trash_order_by(params)
  end
  
  # GET /admin/messages/:id
  def show
    @message = Message.find(params[:id])
    @message.update_attributes!(:read_at => Time.now) if @message.unread?
  end
  
  # PUT /admin/messages/:id/reply
  def reply
    @message = Message.find(params[:id])
    
    flash[:success] = 'Message successfully mark as replied' if @message.update_attributes!(:replied_at => Time.now)
    redirect_to admin_message_path(@message)
  end
  
  # PUT /admin/messages/:id/trash
  def trash
    @message = Message.find(params[:id])
    
    flash[:success] = 'Message successfully trashed' if @message.update_attributes!(:trashed_at => Time.now)
    redirect_to admin_messages_path
  end
  
  # PUT /admin/messages/:id/untrash
  def untrash
    @message = Message.find(params[:id])
    
    flash[:success] = 'Message successfully untrashed' if @message.update_attributes!(:trashed_at => nil)
    redirect_to trashes_admin_messages_path
  end
  
  # DELETE /admin/messages/:id
  def destroy
    @message = Message.find(params[:id])
    
    flash[:success] = 'Message successfully destroyed' if @message.destroy
    redirect_to trashes_admin_messages_path
  end
  
end