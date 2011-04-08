require 'spec_helper'

feature "Logged in" do

  context "as a lambda visitor" do
    background { visit "/" }

    it "should not see program link" do
      page.should_not have_content("Program")
    end
    it "should see application link if application are open, otherwise not" do
      if SiteSettings.applications_open
        page.should have_content("Application")
      else
        page.should_not have_content("Application")
      end
    end
    it "should not see log out link" do
      page.should_not have_content("Log out")
    end
  end

  context "as user" do
    background do
      sign_in_as_user
      visit "/"
    end

    it "should  see program link" do
      page.should have_content("Schedule")
    end
    it "should never see application link" do
      if SiteSettings.applications_open
        page.should_not have_content("Application")
      else
        page.should_not have_content("Application")
      end
    end
    it "should see log out link" do
      page.should have_content("Log out")
    end
  end

  context "as teacher" do
    background do
      sign_in_as_teacher
      visit "/"
    end

    it "should  see program link" do
      page.should have_content("Schedule")
    end
    it "should never see application link" do
      if SiteSettings.applications_open
        page.should_not have_content("Application")
      else
        page.should_not have_content("Application")
      end
    end
    it "should see log out link" do
      page.should have_content("Log out")
    end
  end

end
