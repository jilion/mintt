class Admin::MailTemplatesController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/mail_templates
  def index
    @mail_templates = MailTemplate.all
  end
  
  # GET /admin/mail_template/:id
  def show
    @mail_template = MailTemplate.find(params[:id])
    @user = User.new(:first_name => "Steve", :last_name => "Jobs", :email => "steve@apple.com", :phone => "+41 65 787 25 23", :school => "Apple University", :lab => "Cupertino Infinite Loop", :url => "http://apple.com", :linkedin_url => "http://us.linkedin.com/stevejobs", :thesis_supervisor => "Bill Gates", :thesis_subject => "lorem ipsum...", :thesis_registration_date => 120.days.ago, :thesis_admission_date => 5.days.ago, :thesis_invention => "lorem ipsum...", :motivation => "lorem ipsum...", :confirmation_token => "ddjnwh873r3rnjmd0jdmmniu", :reset_password_token => "ddjnwh873r3rnjmd0jdmmniu")
  end
  
  # GET /admin/mail_template/:id/edit
  def edit
    @mail_template = MailTemplate.find(params[:id])
  end
  
  # PUT /admin/mail_template/:id
  def update
    @mail_template = MailTemplate.find(params[:id])
    if @mail_template.update_attributes(params[:mail_template])
      flash[:success] = 'Mail template successfully updated'
      redirect_to admin_mail_template_path(@mail_template)
    else
      render :edit
    end
  end
  
end