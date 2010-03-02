require 'spec_helper'

describe "Pages" do

  before :all do
    basic_auth('fake', 'fake')
    visit root_path
  end

  it "should be possible to go home" do
    click_link "<span>Home</span>"

    response.should contain('mintt is a course part of the EPFL Doctoral School under the College of Management of Technology program.')
  end

  it "should be possible view modules" do
    basic_auth('fake', 'fake')
    visit root_path
    click_link "Modules"

    response.should contain('Program Overview')
  end

end
