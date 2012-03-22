require 'spec_helper'

describe Teacher do
  describe "from factory" do
    before(:all) do
      @teacher = Factory.build(:teacher)
    end
    subject { @teacher }

    its(:name)  { should eq "John Doe" }
    its(:email) { should match /email[0-9]+@epfl.com/ }

    it { should be_valid }
  end

  describe "Validations" do
    [:name, :email].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    it { should validate_presence_of(:email).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => "Email")) }

    it "without a unique email" do
      Factory(:teacher, :email => "remy@jilion.com")

      teacher = Factory.build(:teacher, :email => "remy@jilion.com")
      teacher.should_not be_valid
      teacher.should have(1).error_on(:email)
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

      it "has accepted invitation" do
        @teacher.should be_invitation_accepted
      end
      it "sends email" do
        ActionMailer::Base.deliveries.size.should == 1
      end
    end

    describe "#years_for_select" do
      context "a teacher with no years" do
        subject { Factory(:teacher) }

        its(:years) { should == [Time.now.utc.year] }
        its(:years_for_select) { should == (2010..Time.now.utc.year).to_a }
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
