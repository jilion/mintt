require 'spec_helper'

describe OneTime do

  describe ".set_users_school_and_lab" do
    before do
      create(:user, :school => "EPFL IC ISC", :lab => "LCAV")
    end

    it "concatenates school and lab field into school_and_lab field" do
      described_class.set_users_school_and_lab

      User.first.school_and_lab.should eq "EPFL IC ISC (lab: LCAV)"
    end
  end

end
