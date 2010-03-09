require 'spec_helper'

describe Message do
  # Waiting for remarkable_mongo to work...
  # it { should have_keys(:sender_name, :sender_email, :content, String) }
  # it { should have_keys(:read, :replied, Boolean) }
  # it { should validate_presence_of(:sender_name, :sender_email, :content) }

  describe "default" do
    subject { Factory(:message) }

    its(:sender_name)   { should == "Joe Blow" }
    its(:sender_email)  { should match /email[0-9]+@epfl.com/ }
    its(:content)       { should == "Advanced Compilation for Mac" }
    its(:read_at)       { should be_nil }
    its(:replied_at)    { should be_nil }
    its(:trashed_at)    { should be_nil }
    it { should be_unread }
    it { should be_unreplied }
    it { should_not be_trashed }
    it { should_not be_read }
    it { should_not be_replied }
    
    it { should be_valid }
  end

  describe "should be invalid" do
    it "without sender_name" do
      Factory(:message, :sender_name => nil).should_not be_valid
    end

    it "without sender_email" do
      Factory(:message, :sender_email => nil).should_not be_valid
    end

    it "without content" do
      Factory(:message, :content => nil).should_not be_valid
    end
  end

end
