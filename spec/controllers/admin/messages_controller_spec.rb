require 'spec_helper'

describe Admin::MessagesController do
  mock_model :message
  
  describe :get => :index, :message => Factory.attributes_for(:message) do
    expects :paginate_all_order_by, :on => Message, :returns => mock_messages
    
    it { should render_template 'admin/messages/index' }
  end
  
  describe :get => :index, :params => { :all => true }, :message => Factory.attributes_for(:message) do
    expects :all_order_by, :on => Message, :returns => mock_messages
    
    it { should render_template 'admin/messages/index' }
  end
  
  describe :get => :show, :message => Factory.attributes_for(:message), :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :unread?, :on => mock_message, :returns => true
    expects :update_attributes!, :on => mock_message, :returns => true
    
    it { should render_template 'admin/messages/show' }
  end
  
  describe :get => :show, :message => Factory.attributes_for(:message).merge({ :read => true }), :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :unread?, :on => mock_message, :returns => false
    
    it { should render_template 'admin/messages/show' }
  end
  
  describe :put => :reply, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :returns => true
    
    it { should redirect_to admin_message_path(mock_message) }
  end
  
  describe :put => :trash, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :returns => true
    
    it { should redirect_to admin_messages_path }
  end
  
  describe :put => :untrash, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :with => { :trashed_at => nil }, :returns => true
    
    it { should redirect_to trashs_admin_messages_path }
  end
  
end
