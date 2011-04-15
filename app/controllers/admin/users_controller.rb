class Admin::UsersController < Admin::AdminController
  respond_to :html, :js
  respond_to :csv, :only => :index

  before_filter :set_year, :only => :index

  # GET /admin/users
  def index
    respond_to do |format|
      if /html|javascript/ =~ request.format
        @users = User.index_order_by(params.merge(:year => session[:admin_year]))
      end
      format.js
      format.html
      format.csv do
        render :csv => User.index_order_by(:all => true, :year => session[:admin_year]).to_a, :filename => "mintt_users-#{I18n.l(Time.now.utc, :format => :filename)}", :style => { :encoding => 'U', :col_sep => ';' }
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
