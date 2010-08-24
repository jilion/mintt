require 'spec_helper'

describe User do
  # Waiting for remarkable_mongo to work...
  # it { should have_keys(:gender, :supervisor_authorization, :doctoral_school_rules, :agreement, Boolean) }
  # it { should have_keys(:first_name, :last_name, :school, :phone, :email, :url, :linkedin_url, :thesis_supervisor, :thesis_subject, :thesis_invention, :motivation, String) }
  # it { should validate_presence_of(:first_name) }
  
  describe "default" do
    subject { Factory(:teacher) }
    
    its(:name)  { should == "John"                    }
    its(:email) { should match /email[0-9]+@epfl.com/ }
    
    it { should be_valid }
  end
  
  describe "should be valid" do
    
    it "with a nil name" do
      t = Factory(:teacher, :name => nil)
      t.should be_valid
      t.name.should be_nil
    end
    
    it "with a nil name" do
      t = Factory(:teacher, :module_id => nil)
      t.should be_valid
      t.module_id.should be_nil
    end
    
  end
  
  describe "should be invalid" do
    
    it "without email" do
      Factory.build(:teacher, :email => nil).should_not be_valid
    end
    
    it "with invalid email" do
      Factory.build(:teacher, :email => 'test').should_not be_valid
    end
    
    it "without a unique email" do
      Factory(:teacher, :email => "remy@jilion.com")
      
      teacher = Factory.build(:teacher, :email => "remy@jilion.com")
      teacher.should_not be_valid
      teacher.errors[:email].should be_present
    end
    
  end
  
  describe "Instance Methods" do
    describe "#has_accepted_invitation?" do
      before :each do
        ActionMailer::Base.deliveries = []
        @teacher = Teacher.invite(:email => "test@test.com")
        Teacher.accept_invitation(:invitation_token => @teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
        @teacher.reload
      end
      
      it "should has accepted invitation" do
        @teacher.should be_has_accepted_invitation
      end
      it "should send email" do
        ActionMailer::Base.deliveries.size.should == 1
      end
    end
    
  end
  
end