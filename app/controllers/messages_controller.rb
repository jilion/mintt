class MessagesController < ApplicationController
  before_filter :ensure_keys_exists
  
  # ssl_required :new, :create
  
  # GET /contact
  def new
    @message = Message.new
  end
  
  # POST /contact
  def create
    @message = Message.new(params[:message])
    
    if @message.save
      flash[:success] = 'Your message has been sent.'
      redirect_to root_url
    else
      render :new
    end
  end
  
end