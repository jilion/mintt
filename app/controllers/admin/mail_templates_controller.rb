class Admin::MailTemplatesController < Admin::AdminController
  respond_to :html

  # GET /admin/mail_templates
  def index
    @mail_templates = MailTemplate.all

    respond_with(@mail_templates)
  end

  # GET /admin/mail_template/:id
  def show
    @mail_template = MailTemplate.find(params[:id])

    respond_with(@mail_template)
end

  # GET /admin/mail_template/:id/edit
  def edit
    @mail_template = MailTemplate.find(params[:id])

    respond_with(@mail_template)
end

  # PUT /admin/mail_template/:id
  def update
    @mail_template = MailTemplate.find(params[:id])

    respond_with(@mail_template) do |format|
      if @mail_template.update_attributes(params[:mail_template])
        format.html { redirect_to [:admin, :mail_templates], :notice => "Mail template successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

end
