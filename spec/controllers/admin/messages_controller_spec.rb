require 'spec_helper'

describe Admin::MessagesController do
  mock_model :message
  
  describe :get => :index, :message => Factory.attributes_for(:message) do
    expects :all_order_by, :on => Message, :returns => mock_messages
    
    it { should render_template 'admin/messages/index' }
  end
  
  describe :get => :show, :message => Factory.attributes_for(:message), :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :with => { :read => true }, :returns => true
    
    it { should render_template 'admin/messages/show' }
  end
  
  describe :put => :update, :message => {}, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :with => { :replied => true }, :returns => true
    
    it { should redirect_to admin_message_path(mock_message) }
  end
  
  describe :delete => :destroy, :message => Factory.attributes_for(:message), :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :with => { :trashed => true }, :returns => true
    
    it { should redirect_to admin_messages_path }
  end
  
end
