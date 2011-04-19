class Admin::MessagesController < Admin::AdminController
  respond_to :html

  # GET /admin/messages
  def index
    @messages = Message.index_order_by(params)

    respond_with(@messages)
end

  # GET /admin/messages/:id
  def show
    @message = Message.find(params[:id])
    @message.update_attribute(:read_at, Time.now.utc) if @message.unread?

    respond_with(@messages)
end

  # PUT /admin/messages/:id
  def update
    @message = Message.find(params[:id])
    @message.update_attributes(params[:message])

    respond_with(@message, :location => admin_messages_path(:trashed => @message.trashed?), :notice => "Message successfully updated.")
  end

end
