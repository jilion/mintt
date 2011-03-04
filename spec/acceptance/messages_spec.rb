feature "Messages" do

  background do
    ActionMailer::Base.deliveries.clear
    visit '/'
  end

  it "should be possible to create" do
    ActionMailer::Base.deliveries.should be_empty
    click_link "Contact"

    current_url.should =~ %r(^http://[^/]+/contact$)

    fill_in "message_sender_name",  :with => "John Doe"
    fill_in "message_sender_email", :with => "remy@jilion.com"
    fill_in "message_content",      :with => "Computer Science..."
    click_button "Send message"

    current_url.should =~ %r(^http://[^/]+/$)

    page.should have_content("Your message has been sent.")
    ActionMailer::Base.deliveries.size.should == 1
  end

end
