require 'spec_helper'

describe Admin::MailTemplatesController do
  
  it { should route(:get, "/admin/mail_templates").to(:action => :index) }
  it { should route(:get, "/admin/mail_templates/1").to(:action => :show,      :id => '1') }
  it { should route(:get, "/admin/mail_templates/1/edit").to(:action => :edit, :id => '1') }
  it { should route(:put, "/admin/mail_templates/1").to(:action => :update,    :id => '1') }
  
end