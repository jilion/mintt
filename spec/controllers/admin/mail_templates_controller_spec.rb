require 'spec_helper'

describe Admin::MailTemplatesController do
  mock_model :mail_template
  
  describe :put => :update, :mail_template => Factory.attributes_for(:mail_template).merge({:not_registered_key => 'foo'}), :id => "1" do
    expects :find, :on => MailTemplate, :with => "1", :returns => mock_mail_template
    expects :update_attributes, :on => mock_mail_template, :returns => true
    
    should_redirect_to { admin_mail_template_path(mock_mail_template) }
    it { params.include?(:not_registered_key).should_not be_true }
  end
  
end
