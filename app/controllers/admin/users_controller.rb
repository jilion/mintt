class Admin::UsersController < ApplicationController

  before_filter :admin_required
  before_filter :find_users
  before_filter :ensure_keys_exists

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
      @users = User.order_by(params)
    end
  end
  
  def ensure_keys_exists
    params[:user].slice(*User.keys.keys) if params[:user]
  end

end
