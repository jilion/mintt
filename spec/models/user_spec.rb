require 'spec_helper'

describe User do
  before(:all) do
    Factory(:mail_template)
  end

  context "from factory" do
    before(:all) do
      @user = Factory.build(:user)
    end
    subject { @user }

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
    its(:agreement)                { should be_true                                     }
    its(:year)                     { should == Time.now.utc.year                        }
    its(:selected_at)              { should be_nil                                      }
    its(:trashed_at)               { should be_nil                                      }

    it { should be_candidate   }
    it { should_not be_trashed }
    it { should be_valid       }
  end

  describe "Validations" do
    [:year, :gender, :first_name, :last_name, :school, :lab, :email, :phone, :url, :linkedin_url, :thesis_supervisor, :thesis_subject, :thesis_invention, :thesis_registration_date, :thesis_admission_date, :supervisor_authorization, :doctoral_school_rules, :motivation].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    [:first_name, :last_name, :school, :lab, :email, :phone, :thesis_supervisor, :thesis_subject].each do |attribute|
      it "validates presence of #{attribute}" do
        should validate_presence_of(attribute).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => attribute.to_s.chars.to_a[0].upcase + attribute.to_s.gsub('_', ' ').chars.to_a[1..-1].join))
      end
    end

    it { should validate_presence_of(:motivation).with_message(I18n.t('mongoid.errors.models.user.attributes.motivation.blank', :attribute => "Motivation")) }

    it { should allow_value('male').for(:gender) }
    it { should allow_value('female').for(:gender) }
    it { should_not allow_value('').for(:gender) }
    it { should_not allow_value('fake').for(:gender) }

    it { should allow_value('yes').for(:supervisor_authorization) }
    it { should allow_value('no').for(:supervisor_authorization) }
    it { should_not allow_value('').for(:supervisor_authorization) }
    it { should_not allow_value('maybe').for(:supervisor_authorization) }

    it { should allow_value('yes').for(:doctoral_school_rules) }
    it { should allow_value('no').for(:doctoral_school_rules) }
    it { should_not allow_value('').for(:doctoral_school_rules) }
    it { should_not allow_value('maybe').for(:doctoral_school_rules) }

    it { should validate_format_of(:url).with(User::URL_REGEX) }
    it { should validate_format_of(:linkedin_url).with(User::LINKEDIN_URL_REGEX) }

    describe "thesis_registration_date" do
      it { Factory.build(:user, :thesis_registration_date => "").should be_valid }
      it { Factory.build(:user, :thesis_admission_date => "").should be_valid }
    end

    it "without a unique email" do
      Factory(:user, :email => "remy@jilion.com")

      user = Factory.build(:user, :email => "remy@jilion.com")
      user.should_not be_valid
      user.should have(1).error_on(:email)
    end

    it "without thesis_registration_date > thesis_admission_date" do
      Factory.build(:user, :thesis_registration_date => 1.day.from_now, :thesis_admission_date => Time.now.utc).should_not be_valid
    end

    it "without thesis_admission_date < thesis_registration_date" do
      Factory.build(:user, :thesis_admission_date => Time.now.utc, :thesis_registration_date => 1.day.from_now).should_not be_valid
    end

    it "without agreement" do
      Factory.build(:user, :agreement => false).should_not be_valid
    end
  end

  describe "Instance Methods" do

    describe "#update_state" do
      context "from state nil to 'selected'" do
        before :each do
          @user = Factory(:user, :state => nil)
          @user.state.should be_nil
          ActionMailer::Base.deliveries.clear
          @user.state = 'selected'
          @user.save
          @user.reload.state.should == 'selected'
        end
        subject { @user }

        it "sets selected_at and reset_password_token" do
          subject.selected_at.should be_within(5).of(Time.now.utc)
          subject.reset_password_token.should be_present
        end

        it "sends email" do
          ActionMailer::Base.deliveries.size.should == 1
        end
      end

      context "from state 'candidate' to 'selected'" do
        before :each do
          @user = Factory(:user, :state => 'candidate')
          @user.state.should == 'candidate'
          ActionMailer::Base.deliveries.clear
          @user.state = 'selected'
          @user.save
          @user.reload.state.should == 'selected'
        end
        subject { @user }

        it "sets selected_at and reset_password_token" do
          subject.selected_at.should be_within(5).of(Time.now.utc)
          subject.reset_password_token.should be_present
        end

        it "sends email" do
          ActionMailer::Base.deliveries.size.should == 1
        end
      end

      context "from state 'selected' to 'candidate'" do
        before :each do
          @user = Factory(:user, :state => 'selected')
          @user.state.should == 'selected'
          ActionMailer::Base.deliveries.clear
          @user.state = 'candidate'
          @user.save
          @user.reload.state.should == 'candidate'
        end
        subject { @user }

        it "clears selected_at and reset_password_token" do
          subject.selected_at.should be_nil
          subject.reset_password_token.should be_nil
        end

        it "doesn't send email" do
          ActionMailer::Base.deliveries.size.should == 0
        end
      end
    end

    describe "#candidate?" do
      it { Factory(:user, :state => 'candidate').should be_candidate }
    end

    describe "#selected?" do
      it { Factory(:user, :state => 'selected').should be_selected }
    end

    describe "#account_created?" do
      before :each do
        @user = Factory(:user)
        @user.update_attribute(:state, 'selected')
        User.reset_password_by_token(:reset_password_token => @user.reset_password_token, :password => '123456', :password_confirmation => '123456')
      end
      subject { @user.reload }

      it "is selected, has an account and clear reset_password_token" do
        subject.should be_selected
        subject.should be_account_created
        subject.reset_password_token.should be_nil
      end
    end

    describe "#trashed?" do
      before :each do
        @user = Factory(:user)
        @user.trashed_at.should be_nil
        @user.should_not be_trashed
      end
      subject { @user }

      it "is trashed" do
        subject.update_attribute(:trashed_at, Time.now.utc)
        subject.reload.trashed_at.should be_present
        subject.should be_trashed
      end
    end

    describe "#full_name" do
      it "returns 'first_name last_name' titleized" do
        Factory(:user, :first_name => 'steve', :last_name => 'jobs').full_name.should == "Steve Jobs"
      end

      it "returns 'last_name first_name' titleized" do
        Factory(:user, :first_name => 'steve', :last_name => 'jobs').full_name(:reverse => true).should == "Jobs Steve"
      end
    end
  end

end
