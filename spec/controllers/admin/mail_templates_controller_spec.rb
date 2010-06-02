require 'spec_helper'

describe Admin::MailTemplatesController do
  mock_model :mail_template, :user, :teacher
  
  # =========
  # = index =
  # =========
  describe :get => :index do
    expects :all, :on => MailTemplate, :returns => mock_mail_templates
    
    it { should render_template 'admin/mail_templates/index.html.haml' }
  end
  
  # ========
  # = show =
  # ========
  describe :get => :show, :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    
    it { should render_template 'admin/mail_templates/show.html.haml' }
  end
  
  describe :get => :show, :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    
    it { should render_template 'admin/mail_templates/show.html.haml' }
  end
  
  # ========
  # = edit =
  # ========
  describe :get => :edit, :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    
    it { should render_template 'admin/mail_templates/edit.html.haml' }
  end
  
  # ==========
  # = update =
  # ==========
  describe :put => :update, :mail_template => { :content => "" }, :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    expects :update_attributes, :on => mock_mail_template, :returns => true
    
    it { should redirect_to admin_mail_template_path(mock_mail_template) }
  end
  
  describe :put => :update, :mail_template => { :content => "" }, :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    expects :update_attributes, :on => mock_mail_template, :returns => false
    
    it { should render_template 'admin/mail_templates/edit.html.haml' }
  end
  
end