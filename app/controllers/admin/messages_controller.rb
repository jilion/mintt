class Admin::MessagesController < Admin::AdminController

  # GET /admin/messages
  def index
    @messages = Message.index_order_by(params)
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /admin/messages/:id
  def show
    @message = Message.find(params[:id])
    @message.update_attribute(:read_at, Time.now.utc) if @message.unread?
  end

  # PUT /admin/messages/:id
  def update
    @message = Message.find(params[:id])
    @message.update_attributes(params[:message])
    redirect_to (admin_messages_path(:trashed => @message.trashed?)), :notice => "Message successfully updated."
  end

end
