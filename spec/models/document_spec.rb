require 'spec_helper'

describe Document do
  
  describe "default" do
    subject { Factory(:document) }
    
    its(:title) { should == "A document" }
    its(:file)  { should be_present      }
    
    it { should be_valid }
  end
  
  describe "should be invalid" do
    
    it "without title" do
      Factory.build(:document, :title => nil).should_not be_valid
    end
    
    it "without file" do
      Factory.build(:document, :file => nil).should_not be_valid
    end
    
  end
  
  describe "Class Methods" do
    
  end
  
  describe "Instance Methods" do
    
  end
  
end