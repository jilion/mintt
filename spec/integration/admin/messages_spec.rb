require 'spec_helper'

describe "Admin messages" do
  
  before(:all) do
    ActionMailer::Base.deliveries.clear
    @messages = 3.times.inject([]) { |memo, i| memo << Factory.create(:message) }
    visit admin_messages_path
  end
  
  it "should be possible to list messages" do
    response.should have_tag("tr", :id => "#message_#{@messages.first.id}")
    response.should have_tag("tr", :id => "#message_#{@messages.last.id}")
  end
  
end