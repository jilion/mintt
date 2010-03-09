require 'spec_helper'

describe PagesController do
  
  # =======
  # = get =
  # =======
  describe :get => :show, :id => 'home' do
    it { should render_template 'pages/home.html.haml' }
  end
  
  describe :get => :show, :id => 'modules' do
    it { should render_template 'pages/modules.html.haml' }
  end
  
end