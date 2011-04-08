require 'spec_helper'

feature "Admin messages" do
  background do
    ActionMailer::Base.deliveries.clear
    @messages = 3.times.inject([]) { |memo, i| memo << Factory(:message) }
    visit '/admin'
  end

  it "should be possible to list messages" do
    ActionMailer::Base.deliveries.size.should == 3

    click_link "Messages"

    current_url.should =~ %r(^http://[^/]+/admin/messages$)

    page.should have_css("tr#message_#{@messages.first.id}")
    page.should have_css("tr#message_#{@messages.last.id}")
    page.should have_css("tr", :count => 4)
  end
end
