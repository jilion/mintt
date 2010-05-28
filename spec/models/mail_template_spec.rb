require 'spec_helper'

describe MailTemplate do
  # Waiting for remarkable_mongo to work...
  # it { should have_keys(:sender_name, :sender_email, :content, String) }
  # it { should have_keys(:read, :replied, Boolean) }
  # it { should validate_presence_of(:sender_name, :sender_email, :content) }
  
  describe "default" do
    subject { Factory(:mail_template) }
    
    its(:title) { should == "test_template" }
    its(:content) { should == "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." }
    
    it { should be_valid }
  end
  
  it "should retrieve existing template" do
    t = Factory(:mail_template)
    MailTemplate.find_by_title('test_template').should eql(t)
  end
  
  describe "should be invalid" do
    it "without title" do
      Factory.build(:mail_template, :title => nil).should_not be_valid
    end
    
    it "without content" do
      Factory.build(:mail_template, :content => nil).should_not be_valid
    end
  end
  
end