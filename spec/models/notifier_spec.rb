require 'spec_helper'

describe Message do
  
  before :all do
    @mess = Factory.create(:message)
  end
  
  describe "new_message" do
    it "should be complete" do
      mail = Notifier.create_new_message(@mess)
      mail.subject.should eql("[Mintt] New contact message")

      mail.from.should == [MINTT_SENDER]
      mail.to.should == [NEW_MESSAGE_RECIPIENT]
      mail.body.should match(/<p>#{@mess.sender_name}<#{@mess.sender_email}>.+<\/p>\n<p><a href="http:\/\/[a-z\.]+\/admin\/messages\/#{@mess.id}">Click here to view it<\/a><\/p>\n<p>#{@mess.content}<\/p>/)
    end
  end

end
