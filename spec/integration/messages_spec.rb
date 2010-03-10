require 'spec_helper'

describe "Messages" do
  
  before :all do
    ActionMailer::Base.deliveries = []
    visit root_path
  end
  
  it "should be possible to create" do
    ActionMailer::Base.deliveries.should be_empty
    click_link "Contact"
    
    fill_in "message_sender_name", :with => "John Doe"
    fill_in "message_sender_email",  :with => "remy@jilion.com"
    fill_in "message_content",    :with => "Computer Science..."
    click_button "Send message"
    
    response.should redirect_to root_url
    
    flash[:success].should contain('Your message has been successfully sent.')
    ActionMailer::Base.deliveries.size.should == 1
  end
  
end