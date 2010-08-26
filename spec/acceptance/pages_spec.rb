require File.dirname(__FILE__) + '/acceptance_helper'

feature "Pages" do
  
  background do
    visit '/'
  end
  
  it "should be possible to go home" do
    click_link "Home"
    
    current_url.should =~ %r(^http://[^/]+/$)
  end
  
  it "should be possible view modules" do
    click_link "Modules"
    
    current_url.should =~ %r(^http://[^/]+/modules$)
  end
  
end