class Admin::MailTemplatesController < ApplicationController

  before_filter :admin_required
  before_filter :find_templates
  before_filter :ensure_keys_exists

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

  private
  def find_templates
    if params[:id]
      @mail_template = MailTemplate.find(params[:id])
    else
      @mail_templates = MailTemplate.all
    end
  end
  
  def ensure_keys_exists
    params[:mail_template].slice(*MailTemplate.keys.keys)  if params[:mail_template]
  end

end
