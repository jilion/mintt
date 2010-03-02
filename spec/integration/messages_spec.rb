require 'spec_helper'

describe "Messages" do

  before :all do
    basic_auth('fake', 'fake')
    visit root_path
  end

  it "should be possible to contact" do
    click_link "Contact"
    
    fill_in "message_sender_name", :with => "John Doe"
    fill_in "message_sender_email",  :with => "remy@jilion.com"
    fill_in "message_content",    :with => "Computer Science..."
    click_button "Send message"
    
    response.should contain('Your message has been successfully sended.')
  end

end
