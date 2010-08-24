require 'spec_helper'

describe MailTemplate do
  
  describe "default" do
    subject { Factory(:mail_template) }
    
    its(:title) { should == "test_template" }
    its(:content) { should == "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua." }
    
    it { should be_valid }
  end
  
  it "should retrieve existing template" do
    t = Factory(:mail_template)
    MailTemplate.where(:title => 'test_template').first.should eql(t)
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