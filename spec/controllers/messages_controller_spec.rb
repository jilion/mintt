require 'spec_helper'

describe MessagesController do
  mock_model :message
  
  describe :post => :create, :message => Factory.attributes_for(:message).merge({ :not_registered_key => 'foo' }) do
    expects :new, :on => Message, :returns => mock_message
    expects :save, :on => mock_message, :returns => true
    
    it { should redirect_to root_url }
    it { params.include?(:not_registered_key).should_not be_true }
  end
  
end
