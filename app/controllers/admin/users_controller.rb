class Admin::UsersController < ApplicationController

  before_filter :admin_required
  before_filter :find_users

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
    flash[:success] = 'User destroyed successfully' if @user.destroy
    redirect_to admin_users_path
  end

  private
  def find_users
    if params[:id]
      @user = User.find(params[:id])
    else
      @users = User.all
    end
  end

end
