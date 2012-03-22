class Admin::MessagesController < Admin::AdminController
  respond_to :html
  respond_to :js, :only => [:index]

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

    url = @message.trashed? ? trash_admin_messages_path : inbox_admin_messages_path
    respond_with(@message, :location => url, :notice => "Message successfully updated.")
  end

end
