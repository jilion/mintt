require 'spec_helper'

describe "Admin messages" do
  
  before :all do
    ActionMailer::Base.deliveries = []
    @messages = 3.times.inject([]) { |memo, i| memo << Factory(:message) }
    visit admin_path
  end
  
  it "should be possible to list messages" do
    ActionMailer::Base.deliveries.size.should == 3
    
    click_link "Messages"
    
    response.should have_tag("tr", :id => "#message_#{@messages.first.id}")
    response.should have_tag("tr", :id => "#message_#{@messages.last.id}")
    response.should have_tag("tr", :count => 4)
  end
  
end