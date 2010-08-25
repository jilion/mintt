class Admin::MailTemplatesController < Admin::AdminController
  
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
    if @mail_template.update_attributes(params[:mail_template])
      redirect_to admin_mail_template_path(@mail_template), :notice => "Mail template successfully updated."
    else
      render :edit
    end
  end
  
end