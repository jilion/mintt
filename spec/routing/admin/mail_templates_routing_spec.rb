require 'spec_helper'

describe Admin::MailTemplatesController do

  it { get("/admin/mail_templates").should route_to('admin/mail_templates#index') }
  it { get("/admin/mail_templates/1").should route_to('admin/mail_templates#show', :id => '1') }
  it { get("/admin/mail_templates/1/edit").should route_to('admin/mail_templates#edit', :id => '1') }
  it { put("/admin/mail_templates/1").should route_to('admin/mail_templates#update', :id => '1') }

end
