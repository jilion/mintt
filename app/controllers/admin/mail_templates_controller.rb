class Admin::MailTemplatesController < Admin::AdminController
  before_filter :ensure_keys_exists
  
  # GET /admin/mail_templates
  def index
    @mail_templates = MailTemplate.all
  end
  
  # GET /admin/mail_template/:id
  def show
    @mail_template = MailTemplate.find(params[:id])
  end
  
  # GET /admin/mail_template/:id/edit
  def edit
    @mail_template = MailTemplate.find(params[:id])
  end
  
  # PUT /admin/mail_template/:id
  def update
    @mail_template = MailTemplate.find(params[:id])
    
    if @mail_template.update_attributes!(params[:mail_template])
      flash[:success] = 'Mail template successfully updated'
      redirect_to admin_mail_template_path(@mail_template)
    else
      render :edit
    end
  end
  
private
  
  def ensure_keys_exists
    params[:mail_template].slice(*MailTemplate.keys.keys) if params[:mail_template]
  end
  
end