require 'spec_helper'

describe Admin::MailTemplatesController do
  mock_model :mail_template
  
  describe :get => :index, :mail_template => Factory.attributes_for(:mail_template) do
    expects :all, :on => MailTemplate, :returns => mock_mail_templates
    
    it { should render_template 'admin/mail_templates/index' }
  end
  
  describe :get => :show, :mail_template => Factory.attributes_for(:mail_template), :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    
    it { should render_template 'admin/mail_templates/show' }
  end
  
  describe :get => :edit, :mail_template => Factory.attributes_for(:mail_template), :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    
    it { should render_template 'admin/mail_templates/edit' }
  end
  
  describe :put => :update, :mail_template => Factory.attributes_for(:mail_template).merge({:not_registered_key => 'foo'}), :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    expects :update_attributes!, :on => mock_mail_template, :returns => true
    
    it { params.include?(:not_registered_key).should_not be_true }
    it { should redirect_to admin_mail_template_path(mock_mail_template) }
  end
  
  describe :put => :update, :mail_template => {}, :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    expects :update_attributes!, :on => mock_mail_template, :returns => false
    
    it { should render_template 'admin/mail_templates/edit' }
  end
  
end
