class Admin::UsersController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  def index
    @users = User.order_by(params)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:success] = 'User successfully updated'
      redirect_to admin_users_path
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    flash[:success] = 'User destroyed successfully' if @user.destroy
    redirect_to admin_users_path
  end
  
private
  
  def ensure_keys_exists
    params[:user].slice(*User.keys.keys) if params[:user]
  end
  
end