require 'spec_helper'

describe Admin::UsersHelper do
  
  # ===============
  # = user_gender =
  # ===============
  describe "user_gender" do
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
  
  # ==================
  # = full_name =
  # ==================
  describe "full_name" do
    describe "with nil user" do
      it "should return nothing" do
        helper.full_name(nil).should == ''
      end
    end
    
    describe "with a valid user and no options" do
      it "should return 'first_name last_name' titleized" do
        helper.full_name(Factory(:user, :first_name => 'steve', :last_name => 'jobs')).should == 'Steve Jobs'
      end
    end
    
    describe "with a valid user and reverse options" do
      it "should return 'first_name last_name' titleized" do
        helper.full_name(Factory(:user, :first_name => 'steve', :last_name => 'jobs'), true).should == 'Jobs Steve'
      end
    end
  end
  
  # =============================
  # = full_name_with_email =
  # =============================
  describe "full_name_with_email" do
    describe "with nil user" do
      it "should return nothing" do
        helper.full_name_with_email(nil).should == ''
      end
    end
    
    describe "with a valid user and no options" do
      it "should return 'first_name last_name' titleized" do
        user = Factory(:user, :first_name => 'steve', :last_name => 'jobs', :email => 'steve@jobs.com')
        helper.full_name_with_email(user).should == "#{helper.full_name(user)} #{mail_to('steve@jobs.com', nil, :encode => 'hex', :subject => 'Mintt program: ')}"
      end
    end
    
    describe "with a valid user and reverse options" do
      it "should return 'first_name last_name mail_to(email, nil, :encode => 'hex', :subject => 'Mintt program: ')' titleized" do
        user = Factory(:user, :first_name => 'steve', :last_name => 'jobs', :email => 'steve@jobs.com')
        helper.full_name_with_email(user, true).should == "#{helper.full_name(user, true)} #{mail_to('steve@jobs.com', nil, :encode => 'hex', :subject => 'Mintt program: ')}"
      end
    end
  end
  
  # ============
  # = user_url =
  # ============
  describe "user_url" do
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
  
  # =====================
  # = user_linkedin_url =
  # =====================
  describe "user_linkedin_url" do
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
  
  # =======================
  # = user_thesis_subject =
  # =======================
  describe "user_thesis_subject" do
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
  
  # ===================
  # = user_motivation =
  # ===================
  describe "user_motivation" do
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