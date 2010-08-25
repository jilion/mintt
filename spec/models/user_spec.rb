require 'spec_helper'

describe User do
  before(:each) do
    Factory.create(:mail_template)
  end
  
  # it { should validate_presence_of(:gender) }
  # it { should validate_presence_of(:first_name) }
  # it { should validate_presence_of(:last_name) }
  # it { should validate_presence_of(:school) }
  # it { should validate_presence_of(:lab) }
  # it { should validate_presence_of(:email) }
  # it { should validate_presence_of(:phone) }
  # it { should validate_presence_of(:thesis_supervisor) }
  # it { should validate_presence_of(:thesis_subject) }
  # it { should validate_presence_of(:motivation) }
  # 
  # it { should validate_format_of(:url).to_allow("http://test.com").not_to_allow("test.com") }
  # it { should validate_format_of(:linkedin_url).to_allow("http://ch.linkedin.com/in/remy").not_to_allow("http://test.com") }
  # 
  # it { should validate_inclusion_of(:gender).to_allow("male", "female") }
  # it { should validate_inclusion_of(:supervisor_authorization).to_allow("yes", "no") }
  # it { should validate_inclusion_of(:doctoral_school_rules).to_allow("yes", "no") }
  
  describe "default" do
    subject { Factory(:user) }
    
    its(:gender)                   { should == "male"                                   }
    its(:first_name)               { should == "John"                                   }
    its(:last_name)                { should == "Doe"                                    }
    its(:school)                   { should == "Computer Science"                       }
    its(:lab)                      { should == "Apple Lab"                              }
    its(:phone)                    { should == "+41 21 0000000"                         }
    its(:email)                    { should match /email[0-9]+@epfl.com/                }
    its(:url)                      { should == "http://jilion.com"                      }
    its(:linkedin_url)             { should == "http://fr.linkedin.com/in/remycoutable" }
    its(:thesis_supervisor)        { should == "Remy Coutable"                          }
    its(:thesis_subject)           { should == "Advanced Compilation for Mac"           }
    its(:supervisor_authorization) { should == "yes"                                    }
    its(:doctoral_school_rules)    { should == "yes"                                    }
    its(:thesis_invention)         { should == "The iPad"                               }
    its(:motivation)               { should == "Huge!"                                  }
    its(:agreement)                { should == "1"                                      }
    its(:year)                     { should == Time.now.year                            }
    its(:selected_at)              { should be_nil                                      }
    its(:trashed_at)               { should be_nil                                      }
    
    it { should be_candidate  }
    it { should_not be_trashed }
    it { should be_valid       }
  end
  
  describe "should be valid" do
    
    it "with a nil thesis_registration_date" do
      u = Factory(:user, :thesis_registration_date => "")
      u.should be_valid
      u.thesis_registration_date.should be_nil
    end
    
    it "with a nil thesis_admission_date" do
      u = Factory(:user, :thesis_admission_date => "")
      u.should be_valid
      u.thesis_admission_date.should be_nil
    end
    
  end
  
  describe "should be invalid" do
    
    it "without gender" do
      Factory.build(:user, :gender => nil).should_not be_valid
    end
    
    it "without first_name" do
      Factory.build(:user, :first_name => nil).should_not be_valid
    end
    
    it "without last_name" do
      Factory.build(:user, :last_name => nil).should_not be_valid
    end
    
    it "without school" do
      Factory.build(:user, :school => nil).should_not be_valid
    end
    
    it "without lab" do
      Factory.build(:user, :lab => nil).should_not be_valid
    end
    
    it "without phone" do
      Factory.build(:user, :phone => nil).should_not be_valid
    end
    
    it "without email" do
      Factory.build(:user, :email => nil).should_not be_valid
    end
    
    it "with invalid email" do
      Factory.build(:user, :email => 'test').should_not be_valid
    end
    
    it "without a unique email" do
      Factory(:user, :email => "remy@jilion.com")
      
      user = Factory.build(:user, :email => "remy@jilion.com")
      user.should_not be_valid
      user.errors[:email].should be_present
    end
    
    it "without thesis_supervisor" do
      Factory.build(:user, :thesis_supervisor => nil).should_not be_valid
    end
    
    it "without thesis_subject" do
      Factory.build(:user, :thesis_subject => nil).should_not be_valid
    end
    
    it "without thesis_registration_date > thesis_admission_date" do
      Factory.build(:user, :thesis_registration_date => 1.day.from_now, :thesis_admission_date => Time.now).should_not be_valid
    end
    
    it "without thesis_admission_date < thesis_registration_date" do
      Factory.build(:user, :thesis_admission_date => Time.now, :thesis_registration_date => 1.day.from_now).should_not be_valid
    end
    
    it "without supervisor_authorization" do
      Factory.build(:user, :supervisor_authorization => nil).should_not be_valid
    end
    
    it "without doctoral_school_rules" do
      Factory.build(:user, :doctoral_school_rules => nil).should_not be_valid
    end
    
    it "without motivation" do
      Factory.build(:user, :motivation => nil).should_not be_valid
    end
    
    it "without agreement" do
      Factory.build(:user, :agreement => false).should_not be_valid
    end
    
  end
  
  describe "Class Methods" do
    
    describe ".should_paginate(params = {})" do
      it "should be true if params doesn't have the :all key " do
        User.should_paginate.should be_true
      end
      it "should be false if params does have the :all key " do
        User.should_paginate(:all => true).should be_false
      end
    end
    
  end
  
  describe "Instance Methods" do
    
    describe "#update_state" do
      context "from state 'candidate' to 'selected'" do
        before :each do
          @user = Factory(:user)
          ActionMailer::Base.deliveries.clear
          @user.update_attributes(:state => 'selected')
        end
        
        it "should set the user' selected_at date to now" do
          @user.selected_at.should > 30.seconds.ago
        end
        
        it "should set the user' reset_password_token" do
          @user.reset_password_token.should be_present
        end
        
        it "should send email" do
          ActionMailer::Base.deliveries.size.should == 1
        end
      end
      
      context "from state 'selected' to 'candidate'" do
        before :each do
          @user = Factory(:user, :state => 'selected')
          ActionMailer::Base.deliveries.clear
          @user.update_attributes(:state => 'candidate')
        end
        
        it "should set the user' selected_at date to nil" do
          @user.selected_at.should be_nil
        end
        
        it "should set the user' reset_password_token to nil" do
          @user.reset_password_token.should be_nil
        end
        
        it "should not send email" do
          ActionMailer::Base.deliveries.size.should == 0
        end
      end
    end
    
    describe "#candidate?" do
      before :each do
        @user = Factory(:user, :state => 'candidate')
      end
      
      it "should be candidate" do
        @user.should be_candidate
      end
    end
    
    describe "#selected?" do
      before :each do
        @user = Factory(:user, :state => 'selected')
      end
      
      it "should be selected" do
        @user.should be_selected
      end
    end
    
    describe "#has_created_account?" do
      before :each do
        @user = Factory(:user, :state => 'selected')
        @user.send_reset_password_instructions
        User.reset_password_by_token(:reset_password_token => @user.reset_password_token, :password => '123456', :password_confirmation => '123456')
        @user.reload
      end
      
      it "should be selected" do
        @user.should be_selected
      end
      it "should has created account" do
        @user.should be_has_created_account
      end
      it "should not have reset_password_token" do
        @user.reset_password_token.should be_nil
      end
    end
    
    describe "#trashed?" do
      before :each do
        @user = Factory(:user)
      end
      
      it "should not be trashed by default" do
        @user.should_not be_trashed
      end
      it "should be trashed" do
        @user.update_attributes(:trashed_at => Time.now)
        @user.should be_trashed
      end
    end
    
  end
  
end