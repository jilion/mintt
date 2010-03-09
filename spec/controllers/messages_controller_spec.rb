require 'spec_helper'

describe MessagesController do
  mock_model :message
  
  # =======
  # = get =
  # =======
  describe :get => :new do
    expects :new, :on => Message, :returns => mock_message
    
    it { should render_template 'messages/new.html.haml' }
  end
  
  # ========
  # = post =
  # ========
  describe :post => :create do # successful
    expects :new, :on => Message, :returns => mock_message
    expects :save, :on => mock_message, :returns => true
    
    it { should redirect_to root_url }
  end
  
  describe :post => :create do # fail
    expects :new, :on => Message, :returns => mock_message
    expects :save, :on => mock_message, :returns => false
    
    it { should render_template 'messages/new.html.haml' }
  end
  
end
