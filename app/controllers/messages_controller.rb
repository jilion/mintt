class MessagesController < ApplicationController
  before_filter :ensure_keys_exists
  
  # GET /contact
  def new
    @message = Message.new
  end
  
  # POST /contact
  def create
    @message = Message.new(params[:message])
    
    if @message.save
      flash[:success] = 'Your message has been successfully sent.'
      redirect_to root_url
    else
      render :new
    end
  end
  
private
  
  def ensure_keys_exists
    params[:message].slice(*Message.keys.keys)  if params[:message]
  end
  
end