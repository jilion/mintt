require 'spec_helper'

describe User do
  # Waiting for remarkable_mongo to work...
  # it { should have_keys(:gender, :supervisor_authorization, :doctoral_school_rules, :agreement, Boolean) }
  # it { should have_keys(:first_name, :last_name, :faculty, :phone, :email, :url, :linkedin_url, :thesis_supervisor, :thesis_subject, :thesis_invention, :motivation, String) }
  # it { should validate_presence_of(:first_name) }

  describe "default" do
    subject { Factory(:user) }

    its(:gender) { should == "male" }
    its(:first_name) { should == "Joe" }
    its(:last_name) { should == "Blow" }
    its(:faculty) { should == "Computer Science" }
    its(:phone) { should == "+41 21 0000000" }
    its(:email) { should match /email[0-9]+@epfl.com/ }
    its(:url) { should == "http://jilion.com" }
    its(:linkedin_url) { should == "http://fr.linkedin.com/in/remycoutable" }
    its(:thesis_supervisor) { should == "Remy Coutable" }
    its(:thesis_subject) { should == "Advanced Compilation for Mac" }
    its(:supervisor_authorization) { should == "yes" }
    its(:doctoral_school_rules) { should == "yes" }
    its(:thesis_invention) { should == "The iPad" }
    its(:motivation) { should == "Huge!" }
    its(:agreement) { should == "1" }

    it { should be_valid }
  end

  describe "should be invalid" do
    it "without gender" do
      Factory(:user, :gender => nil).should_not be_valid
    end

    it "without first_name" do
      Factory(:user, :first_name => nil).should_not be_valid
    end

    it "without last_name" do
      Factory(:user, :last_name => nil).should_not be_valid
    end

    it "without faculty" do
      Factory(:user, :faculty => nil).should_not be_valid
    end

    it "without last_name" do
      Factory(:user, :phone => nil).should_not be_valid
    end

    it "without last_name" do
      user = Factory(:user, :email => nil)
      user.should_not be_valid
    end

    it "without a unique email" do
      valid_user = Factory.create(:user, :email => "remy@jilion.com")
      
      u = Factory.build(:user, :email => "remy@jilion.com")
      u.valid?
      u.errors.on(:email).should == "has already been taken"
    end

    it "without thesis_supervisor" do
      Factory(:user, :thesis_supervisor => nil).should_not be_valid
    end

    it "without thesis_subject" do
      Factory(:user, :thesis_subject => nil).should_not be_valid
    end

    it "without thesis_registration_date > thesis_admission_date" do
      Factory(:user, :thesis_registration_date => 1.day.from_now, :thesis_admission_date => Time.now).should_not be_valid
    end

    it "without thesis_admission_date < thesis_registration_date" do
      Factory(:user, :thesis_admission_date => Time.now, :thesis_registration_date => 1.day.from_now).should_not be_valid
    end

    it "without supervisor_authorization" do
      Factory(:user, :supervisor_authorization => nil).should_not be_valid
    end

    it "without doctoral_school_rules" do
      Factory(:user, :doctoral_school_rules => nil).should_not be_valid
    end

    it "without agreement" do
      Factory(:user, :agreement => false).should_not be_valid
    end
  end

end
