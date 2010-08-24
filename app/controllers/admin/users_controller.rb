class Admin::UsersController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/users
  def index
    respond_to do |format|
      if /html|javascript/ =~ request.format
        @users = User.index_order_by(params)
      end
      format.js
      format.html
      format.csv do
        render :csv => User.index_order_by(:all => true), :filename => "mintt_users-#{I18n.l(Time.now, :format => :filename)}.csv", :style => { :encoding => 'U', :col_sep => ';' }
      end
    end
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
      flash[:success] = 'Student has been successfully updated'
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  
  # PUT /admin/users/:id/trash
  def trash
    @user = User.find(params[:id])
    
    flash[:success] = 'Student has been successfully trashed' if @user.update_attributes(:trashed_at => Time.now)
    redirect_to admin_users_path
  end
  
  # DELETE /admin/users/:id
  def destroy
    @user = User.find(params[:id])
    flash[:success] = 'Student has been successfully destroyed' if @user.destroy
    redirect_to admin_users_path
  end
  
end