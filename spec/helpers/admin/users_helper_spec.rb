require 'spec_helper'

describe Admin::UsersHelper do
  
  describe "#user_gender" do
    describe "with nil user" do
      it "should return nothing" do
        helper.user_gender(nil).should == ''
      end
    end
    
    describe "with a valid user" do
      it "should return M for male, F for female" do
        helper.user_gender(Factory(:user, :gender => 'male')).should == 'M'
        helper.user_gender(Factory(:user, :gender => 'female')).should == 'F'
      end
    end
  end

  describe "#user_url" do
    describe "with nil user" do
      it "should return nothing" do
        helper.user_url(nil).should == ''
      end
    end
    
    describe "with a valid user (and a blank url)" do
      it "should return 'none'" do
        user = Factory(:user, :url => '')
        helper.user_url(user).should == "none"
      end
    end
    
    describe "with a valid user (and a non-blank url)" do
      it "should return a link to the url with window.open" do
        user = Factory(:user, :url => 'http://jilion.com')
        helper.user_url(user).should == "#{link_to('http://jilion.com', 'http://jilion.com', :onclick => "window.open(this); return false")}"
      end
    end
  end
  
  describe "#user_linkedin_url" do
    describe "with nil user" do
      it "should return nothing" do
        helper.user_linkedin_url(nil).should == ''
      end
    end
    
    describe "with a valid user (and a blank linkedin_url)" do
      it "should return 'none'" do
        user = Factory(:user, :linkedin_url => '')
        helper.user_linkedin_url(user).should == "none"
      end
    end
    
    describe "with a valid user (and a non-blank linkedin_url)" do
      it "should return a link to the url with window.open" do
        user = Factory(:user, :linkedin_url => 'http://fr.linkedin.com/in/remycoutable')
        helper.user_linkedin_url(user).should == "#{link_to('http://fr.linkedin.com/in/remycoutable', 'http://fr.linkedin.com/in/remycoutable', :onclick => "window.open(this); return false")}"
      end
    end
  end
  
  describe "#user_thesis_subject" do
    describe "with nil user" do
      it "should return nothing" do
        helper.user_thesis_subject(nil).should == ''
      end
    end
    
    describe "with a valid user" do
      it "should return thesis_subject truncated with the first 50 chars" do
        user = Factory(:user, :thesis_subject => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
        helper.user_thesis_subject(user).should == "Lorem ipsum dolor sit amet, consectetur adipisi..."
      end
    end
  end
  
  describe "#user_motivation" do
    describe "with nil user" do
      it "should return nothing" do
        helper.user_motivation(nil).should == ''
      end
    end
    
    describe "with a valid user" do
      it "should return thesis_subject truncated with the first 50 chars" do
        user = Factory(:user, :motivation => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
        helper.user_motivation(user).should == "Lorem ipsum dolor sit amet, consectetur adipisi..."
      end
    end
  end
  
end