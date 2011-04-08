require 'spec_helper'

describe User do
  let(:teacher) { Factory(:teacher) }

  describe "default" do
    subject { teacher }

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
    describe "#invitation_accepted?" do
      before :each do
        ActionMailer::Base.deliveries = []
        @teacher = Teacher.invite!(:email => "test@test.com")
        Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
        @teacher.reload
      end

      it "should has accepted invitation" do
        @teacher.should be_invitation_accepted
      end
      it "should send email" do
        ActionMailer::Base.deliveries.size.should == 1
      end
    end
    
    describe "#years_for_select", :focus => true do
      context "a teacher with no years" do
        subject { Factory(:teacher) }
        
        its(:years) { should == [Time.now.utc.year] }
        its(:years_for_select) { should == [Time.now.utc.year] }
      end
      
      context "a teacher with 1 year of activity" do
        subject { Factory(:teacher, :years => [2010]) }
        
        its(:years) { should == [2010] }
        its(:years_for_select) { should == (2010..Time.now.utc.year).to_a }
      end
      
      context "a teacher with 2 years of activity" do
        subject { Factory(:teacher, :years => [2009, 2010]) }
        
        its(:years) { should == [2009, 2010] }
        its(:years_for_select) { should == (2009..Time.now.utc.year).to_a }
      end
    end
  end

end
