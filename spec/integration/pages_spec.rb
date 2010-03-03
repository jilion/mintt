require 'spec_helper'

describe "Pages" do

  before :all do
    visit root_path
  end

  it "should be possible to go home" do
    click_link "<span>Home</span>"

    response.should contain('mintt is a course for EPFL PhD students organized by EPFL Technology Transfer Office.')
  end

  it "should be possible view modules" do
    basic_auth('fake', 'fake')
    visit root_path
    click_link "Modules"

    response.should contain('Program Overview')
  end

end
