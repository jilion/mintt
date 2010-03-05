require 'spec_helper'

describe "Pages" do
  
  before :all do
    visit root_path
  end
  
  it "should be possible to go home" do
    click_link "<span>Home</span>"
    
    response.should render_template 'pages/home'
  end
  
  it "should be possible view modules" do
    visit root_path
    click_link "Modules"
    
    response.should render_template 'pages/modules'
  end
  
end