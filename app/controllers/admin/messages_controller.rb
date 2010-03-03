class Admin::MessagesController < ApplicationController
  
  before_filter :admin_required
  before_filter :find_messages
  
  layout 'admin'
  
  def index
  end
  
  def show
  end

  def edit

  end

  def update

  end

  def destroy
    flash[:success] = 'Message destroyed successfully' if @message.destroy
    redirect_to admin_messages_path
  end

  private
  def find_messages
    if params[:id]
      @message = Message.find(params[:id])
    else
      @messages = Message.all
    end
  end

end
  