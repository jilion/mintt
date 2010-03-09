require 'spec_helper'

describe Admin::MessagesController do
  mock_model :message
  
  # =========
  # = index =
  # =========
  describe :get => :index, :page => 2 do
    expects :index_order_by, :on => Message, :with => { "action" => "index", "controller" => "admin/messages", "page" => "2" }, :returns => mock_messages
    
    it { should render_template 'admin/messages/index.html.haml' }
  end
  
  describe :get => :index, :all => true do
    expects :index_order_by, :on => Message, :with => { "all" => true, "action" => "index", "controller" => "admin/messages" }, :returns => mock_messages
    
    it { should render_template 'admin/messages/index.html.haml' }
  end
  
  # ==========
  # = trashs =
  # ==========
  describe :get => :trashs, :page => 2 do
    expects :trash_order_by, :on => Message, :with => { "action" => "trashs", "controller" => "admin/messages", "page" => "2" }, :returns => mock_messages
    
    it { should render_template 'admin/messages/trashs.html.haml' }
  end
  
  describe :get => :trashs, :all => true do
    expects :trash_order_by, :on => Message, :with => { "all" => true, "action" => "trashs", "controller" => "admin/messages" }, :returns => mock_messages
    
    it { should render_template 'admin/messages/trashs.html.haml' }
  end
  
  # ========
  # = show =
  # ========
  describe :get => :show, :message => Factory.attributes_for(:message), :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :unread?, :on => mock_message, :returns => true
    expects :update_attributes!, :on => mock_message, :returns => true
    
    it { should render_template 'admin/messages/show.html.haml' }
  end
  
  describe :get => :show, :message => Factory.attributes_for(:message).merge({ :read => true }), :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :unread?, :on => mock_message, :returns => false
    
    it { should render_template 'admin/messages/show.html.haml' }
  end
  
  # =========
  # = reply =
  # =========
  describe :put => :reply, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :returns => true
    
    it { should redirect_to admin_message_path(mock_message) }
  end
  
  # =========
  # = trash =
  # =========
  describe :put => :trash, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :returns => true
    
    it { should redirect_to admin_messages_path }
  end
  
  # ===========
  # = untrash =
  # ===========
  describe :put => :untrash, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :update_attributes!, :on => mock_message, :with => { :trashed_at => nil }, :returns => true
    
    it { should redirect_to trashs_admin_messages_path }
  end
  
  # ===========
  # = destroy =
  # ===========
  describe :delete => :destroy, :id => "1" do
    expects :find, :on => Message, :with => "1", :returns => mock_message
    expects :destroy, :on => mock_message, :returns => true
    
    it { should redirect_to trashs_admin_messages_path }
  end
  
end
