require 'spec_helper'

describe TeachingModule do
  describe "from factory" do
    before(:all) do
      @teaching_module = Factory.build(:teaching_module)
    end
    subject { @teaching_module }

    its(:title)     { should =~ /Evaluate the Potential \d+/ }
    its(:year)      { should == 2010 }

    it { should be_valid }
  end

  describe "Validations" do
    [:title, :year].each do |attribute|
      it { should allow_mass_assignment_of(attribute) }
    end

    [:title, :year].each do |attribute|
      it "validates presence of #{attribute}" do
        should validate_presence_of(attribute).with_message(I18n.t('mongoid.errors.messages.blank', :attribute => attribute.to_s.chars.to_a[0].upcase + attribute.to_s.gsub('_', ' ').chars.to_a[1..-1].join))
      end
    end

    it "without a unique module id for a year" do
      first_teaching_module = Factory(:teaching_module, :year => 2010)

      teaching_module = Factory.build(:teaching_module, :year => 2010, :module_id => first_teaching_module.module_id)
      teaching_module.should_not be_valid
      teaching_module.should have(1).error_on(:module_id)
    end

    it "without a unique title for a year" do
      Factory(:teaching_module, :year => 2010, :title => "Test")

      teaching_module = Factory.build(:teaching_module, :year => 2010, :title => "Test")
      teaching_module.should_not be_valid
      teaching_module.should have(1).error_on(:title)

      teaching_module = Factory.build(:teaching_module, :year => 2011, :title => "Test")
      teaching_module.should be_valid
    end
  end

  describe "Callbacks" do
    it "isn't possible to delete a module that is not the last" do
      module1 = Factory(:teaching_module, :year => 2010, :title => "Test1")
      module2 = Factory(:teaching_module, :year => 2010, :title => "Test2")

      module1.destroy.should be_false
    end
  end

end
