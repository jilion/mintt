class MessagesController < ApplicationController
  respond_to :html

  # GET /contact
  def new
    @message = Message.new
  end

  # POST /contact
  def create
    @message = Message.new(params[:message])

    respond_with(@message) do |format|
      if @message.save
        format.html { redirect_to root_url, :notice => "Your message has been sent." }
      else
        format.html { render :new }
      end
    end
  end

end
