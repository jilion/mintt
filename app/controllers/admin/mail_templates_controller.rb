class Admin::MailTemplatesController < ApplicationController

  before_filter :admin_required
  before_filter :find_templates

  layout 'admin'

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @mail_template.update_attributes(params[:mail_template])
      flash[:success] = 'Template successfully updated'
      redirect_to admin_mail_template_path(@mail_template)
    else
      render :edit
    end
  end

  # def destroy
  #   flash[:success] = 'MailTemplate destroyed successfully' if @mail_template.destroy
  #   redirect_to admin_mail_templates_path
  # end

  private
  def find_templates
    if params[:id]
      @mail_template = MailTemplate.find(params[:id])
    else
      @mail_templates = MailTemplate.all
    end
  end

end
