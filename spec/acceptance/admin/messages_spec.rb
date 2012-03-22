require 'spec_helper'

feature "/admin/messages" do
  background do
    ActionMailer::Base.deliveries.clear
    @inbox_messages = 3.times.inject([]) { |memo, i| memo << create(:message) }
    @trash_messages = 2.times.inject([]) { |memo, i| memo << create(:message, :trashed_at => Time.now) }
    visit '/admin'
  end

  it "lists inbox messages" do
    ActionMailer::Base.deliveries.size.should eq @inbox_messages.size + @trash_messages.size

    click_link "Messages"

    current_url.should =~ %r(^http://[^/]+/admin/messages/inbox$)

    page.should have_css("tr#message_#{@inbox_messages.first.id}")
    page.should have_css("tr#message_#{@inbox_messages.last.id}")
    page.should have_css("tr", :count => @inbox_messages.size + 1)
  end

  it "lists trash messages" do
    ActionMailer::Base.deliveries.size.should eq @inbox_messages.size + @trash_messages.size

    click_link "Messages"
    click_link "Go to Trash"

    current_url.should =~ %r(^http://[^/]+/admin/messages/trash$)

    page.should have_css("tr#message_#{@trash_messages.first.id}")
    page.should have_css("tr#message_#{@trash_messages.last.id}")
    page.should have_css("tr", :count => @trash_messages.size + 1)
  end
end
