require 'spec_helper'

describe Document do
  
  describe "default" do
    subject { Factory(:document) }
    
    its(:title)    { should == "A document" }
    its(:filename) { should be_present      }
    
    it { should be_valid }
  end
  
  describe "should be invalid" do
    
    it "without filename" do
      Factory.build(:document, :filename => nil).should_not be_valid
    end
    
  end
  
  describe "should be valid" do
    it "without title" do
      Factory.build(:document, :title => nil).should be_valid
    end
    
    it "without module_id" do
      Factory.build(:document, :module_id => nil).should be_valid
    end
  end
    
  describe "Class Methods" do
    
  end
  
  describe "Instance Methods" do
    
    describe "#published?" do
      it "should be published?" do
        Factory(:document, :published_at => 2.days.ago).should be_published
      end
      
      it "should not be published?" do
        Factory(:document, :published_at => 2.days.from_now).should_not be_published
      end
    end
    
  end
  
end