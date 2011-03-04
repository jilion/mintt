require 'spec_helper'

describe Message do
  let(:message) { Factory(:message) }

  context "with valid attributes" do
    subject { message }

    its(:sender_name)   { should == "John Doe" }
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
      Factory.build(:message, :sender_name => nil).should_not be_valid
    end

    it "without sender_email" do
      Factory.build(:message, :sender_email => nil).should_not be_valid
    end

    it "without content" do
      Factory.build(:message, :content => nil).should_not be_valid
    end

    it "with bad email format" do
      Factory.build(:message, :sender_email => "adasdasd").should_not be_valid
    end
  end

end
