require 'spec_helper'

describe User do
  
  describe "default" do
    subject { Factory.build(:user) }
    
    its(:first_name) { should == "Joe" }
    its(:last_name) { should == "Blow" }
    its(:gender) { should be_true }
    its(:faculty) { should == "Computer Science" }
    its(:phone) { should == "+41 21 0000000" }
    its(:email) { should match /email[0-9]+@epfl.com/ }
    its(:url) { should == "http://jilion.com" }
    its(:linkedin_url) { should == "http://fr.linkedin.com/in/remycoutable" }
    its(:thesis_supervisor) { should == "Remy Coutable" }
    its(:thesis_subject) { should == "Advanced Compilation for Mac" }
    its(:supervisor_authorization) { should be_true }
    its(:doctoral_school_rules) { should be_true }
    its(:thesis_invention) { should == "The iPad" }
    its(:motivation) { should == "Huge!" }
    its(:agreement) { should be_true }
    
    it { should be_valid }
  end
  
end
