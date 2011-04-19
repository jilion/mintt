require 'spec_helper'

describe Message do

  context "from Factory" do
    subject { Factory.build(:message) }

    its(:sender_name)  { should == "John Doe" }
    its(:sender_email) { should match /email[0-9]+@epfl.com/ }
    its(:content)      { should == "Advanced Compilation for Mac" }
    its(:read_at)      { should be_nil }
    its(:replied_at)   { should be_nil }
    its(:trashed_at)   { should be_nil }

    it { should be_unread }
    it { should be_unreplied }
    it { should_not be_trashed }
    it { should_not be_read }
    it { should_not be_replied }

    it { should be_valid }
  end

  describe "Validations" do
    [:sender_name, :sender_email, :content, :read_at, :replied_at, :trashed_at].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    [:sender_name, :sender_email, :content].each do |attribute|
      it "validates presence of #{attribute}" do
        should validate_presence_of(attribute).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => attribute.to_s.chars.to_a[0].upcase + attribute.to_s.gsub('_', ' ').chars.to_a[1..-1].join))
      end
    end

    it { should validate_format_of(:sender_email).with(Devise.email_regexp) }
  end

end
