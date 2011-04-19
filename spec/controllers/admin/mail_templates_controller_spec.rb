require 'spec_helper'

describe Admin::MailTemplatesController do

  it "responds with success to GET :index" do
    MailTemplate.stub(:all).and_return([])
    get :index, :page => 2
    response.should render_template(:index)
  end

  it "responds with success to GET :show" do
    MailTemplate.stub(:find).and_return(mock_mail_template)
    get :show, :id => 1
    response.should render_template(:show)
  end

  it "responds with success to GET :edit" do
    MailTemplate.stub(:find).and_return(mock_mail_template)
    get :edit, :id => '1'
    response.should render_template(:edit)
  end

  it "responds with success to PUT :update successful" do
    MailTemplate.stub(:find).and_return(mock_mail_template)
    mock_mail_template.stub(:update_attributes).and_return(true)
    put :update, :id => '1'
    response.should redirect_to([:admin, :mail_templates])
  end

  it "responds with success to PUT :update unsuccessful" do
    MailTemplate.stub(:find).and_return(mock_mail_template)
    mock_mail_template.stub(:update_attributes).and_return(false)
    put :update, :id => '1'
    response.should render_template(:edit)
  end

end
