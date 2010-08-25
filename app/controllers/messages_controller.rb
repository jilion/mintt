class MessagesController < ApplicationController
  
  # GET /contact
  def new
    @message = Message.new
  end
  
  # POST /contact
  def create
    @message = Message.new(params[:message])
    
    if @message.save
      redirect_to root_url, :notice => "Your message has been sent."
    else
      render :new
    end
  end
  
end