require 'spec_helper'

describe MailTemplate do

  context "from Factory" do
    subject { Factory.build(:mail_template) }

    its(:title)   { should =~ /test template \d/ }
    its(:content) { should =~ /Lorem ipsum dolor sit amet/ }

    it { should be_valid }
  end

  describe "Validations" do
    [:title, :content].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    [:title, :content].each do |attribute|
      it "should validates presence of #{attribute}" do
        should validate_presence_of(attribute).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => attribute.to_s.chars.to_a[0].upcase + attribute.to_s.gsub('_', ' ').chars.to_a[1..-1].join))
      end
    end

    it { should validate_uniqueness_of(:title).with_message(I18n.t('mongoid.errors.messages.taken', :attribute => "Title")) }
  end

end
