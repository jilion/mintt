class Admin::UsersController < Admin::AdminController
  
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
      redirect_to admin_users_path, :notice => "Student has been successfully updated"
    else
      render :edit
    end
  end
  
end