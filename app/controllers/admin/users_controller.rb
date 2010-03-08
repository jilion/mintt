class Admin::UsersController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/users
  def index
    @users = User.all_order_by(params.slice(:order_by, :sort_way), { :confirmed_at.ne => nil , :page => params[:page] })
  end
  
  # GET /admin/users/:id
  def show
    @user = User.find(params[:id])
  end
  
  # GET /admin/users/:id/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # PUT /admin/users/:id
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:success] = 'User successfully updated'
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  
  # DELETE /admin/users/:id
  def destroy
    @user = User.find(params[:id])
    flash[:success] = 'User successfully destroyed' if @user.destroy
    redirect_to admin_users_path
  end
  
private
  
  def ensure_keys_exists
    params[:user].slice(*User.keys.keys) if params[:user]
  end
  
end