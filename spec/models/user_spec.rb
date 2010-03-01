require 'spec_helper'

describe User do
  
  describe "default" do
    subject { Factory.build(:user) }
    
    its(:email) { should match /email[0-9]+@epfl.com/ }
    it { should be_valid }
  end
  
end
