require 'spec_helper'

describe "Admin messages" do
  
  before :all do
    ActionMailer::Base.deliveries.clear
    @messages = []
    10.times { @messages << Factory.create(:message) }
    @messages.size.should == 10
    visit admin_users_path
  end
  
  it "should be possible to list messages" do
    click_link "Messages"
    
    # should have_selector "#message_#{@messages.first.id}"
    # should have_selector "#message_#{@messages.last.id}"
  end
  
end