require 'spec_helper'

describe MessagesController do
  mock_model :message
  
  describe :get => :new, :message => Factory.attributes_for(:message) do
    expects :new, :on => Message, :returns => mock_message
    
    it { should render_template 'messages/new' }
  end
  
  describe :post => :create, :message => Factory.attributes_for(:message).merge({ :not_registered_key => 'foo' }) do
    expects :new, :on => Message, :returns => mock_message
    expects :save, :on => mock_message, :returns => true
    
    it { params.include?(:not_registered_key).should_not be_true }
    it { should redirect_to root_url }
  end
  
  describe :post => :create, :message => {} do
    expects :new, :on => Message, :returns => mock_message
    expects :save, :on => mock_message, :returns => false
    
    it { should render_template 'messages/new' }
  end
  
end
