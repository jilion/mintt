require 'spec_helper'

describe "Admin messages" do

  before :all do
    ActionMailer::Base.deliveries.clear
    @messages = []
    10.times { @messages << Factory.create(:message) }
    @messages.size.should == 10
    visit admin_path
  end

  it "should be possible to list messages" do
    click_link "Messages"

    assert_have_selector "#message_#{@messages.first.id}"
    assert_have_selector "#message_#{@messages.last.id}"

    # deleted_id = @messages.first.id
    # click_button "delete_message_#{deleted_id}"
    # @messages.size.should == 9
    # @messages.map(&:id).should_not.include? deleted_id
    # 
    # deleted_id = @messages.last.id
    # click_button "delete_message_#{deleted_id}"
    # @messages.size.should == 8
    # @messages.map(&:id).should_not.include? deleted_id
        
    # fill_in "message_sender_name", :with => "John Doe"
    # fill_in "message_sender_email",  :with => "remy@jilion.com"
    # fill_in "message_content",    :with => "Computer Science..."
    # click_button "Send message"
    # 
    # response.should contain('Your message has been successfully sent.')
    # ActionMailer::Base.deliveries.size.should == 1
  end

end
