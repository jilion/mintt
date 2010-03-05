class Admin::MessagesController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  def index
    params[:order_by] ||= 'created_at'
    params[:sort_way] ||= 'desc'
    @messages = Message.order_by(params)
  end
  
  def show
    @message = Message.find(params[:id])
    # @message.update_attribute(:read, true)
  end
  
  def destroy
    @message = Message.find(params[:id])
    flash[:success] = 'Message destroyed successfully' if @message.destroy
    redirect_to admin_messages_path
  end
  
private
  
  def ensure_keys_exists
    params[:message].slice(*Message.keys.keys) if params[:message]
  end
  
end