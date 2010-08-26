require 'spec_helper'

describe MailTemplate do
  let(:mail_template) { Factory(:mail_template) }
  
  context "with valid attributes" do
    subject { mail_template }
    
    its(:title)   { should =~ /test template \d/ }
    its(:content) { should =~ /Lorem ipsum dolor sit amet/ }
    
    it { should be_valid }
  end
  
  describe "should be invalid" do
    it "without title" do
      Factory.build(:mail_template, :title => nil).should_not be_valid
    end
    
    it "without a unique title" do
      Factory(:mail_template, :title => "test_template")
      
      mt = Factory.build(:mail_template, :title => "test_template")
      mt.should_not be_valid
      mt.errors[:title].should be_present
    end
    
    it "without content" do
      Factory.build(:mail_template, :content => nil).should_not be_valid
      Factory.build(:mail_template, :content => "").should_not be_valid
    end
  end
  
end