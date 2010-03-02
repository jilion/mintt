require 'spec_helper'

describe User do
  # Waiting for remarkable_mongo to work...
  # it { should have_keys(:gender, :supervisor_authorization, :doctoral_school_rules, :agreement, Boolean) }
  # it { should have_keys(:first_name, :last_name, :faculty, :phone, :email, :url, :linkedin_url, :thesis_supervisor, :thesis_subject, :thesis_invention, :motivation, String) }
  # it { should validate_presence_of(:first_name) }

  describe "default" do
    subject { Factory(:user) }

    its(:gender) { should be_true }
    its(:first_name) { should == "Joe" }
    its(:last_name) { should == "Blow" }
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

  describe "should be invalid" do
    # it "without gender" do
    #   user = Factory(:user, :gender => nil)
    #   p user.errors
    #   user.should_not be_valid
    # end

    it "without first_name" do
      user = Factory(:user, :first_name => nil).should_not be_valid
    end

    it "without last_name" do
      user = Factory(:user, :last_name => nil).should_not be_valid
    end

    it "without faculty" do
      user = Factory(:user, :faculty => nil).should_not be_valid
    end

    it "without last_name" do
      user = Factory(:user, :phone => nil).should_not be_valid
    end

    it "without last_name" do
      user = Factory(:user, :email => nil).should_not be_valid
    end

    it "without a unique email" do
      valid_user = Factory.create(:user, :email => "remy@jilion.com")
      valid_user.should be_valid

      Factory(:user, :email => "remy@jilion.com").should_not be_valid
    end

    it "without thesis_supervisor" do
      user = Factory(:user, :thesis_supervisor => nil).should_not be_valid
    end

    it "without thesis_subject" do
      user = Factory(:user, :thesis_subject => nil).should_not be_valid
    end

    # it "without supervisor_authorization" do
    #   user = Factory(:user, :supervisor_authorization => nil).should_not be_valid
    # end

    # it "without doctoral_school_rules" do
    #   user = Factory(:user, :doctoral_school_rules => nil).should_not be_valid
    # end

    # it "without agreement" do
    #   user = Factory(:user, :agreement => nil).should_not be_valid
    # end
  end

end
