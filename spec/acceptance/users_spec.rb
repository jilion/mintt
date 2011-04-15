require 'spec_helper'

feature "User" do

  context "which is not logged in" do
    background do
      visit "/"
    end

    scenario "sees the 'Home' link and can visit the page" do
      click_link "Home"
      current_url.should =~ %r(^http://[^/]+/$)
    end

    scenario "doesn't see the program link" do
      page.should_not have_content("Program")
    end

    scenario "sees the 'Modules' link and can visit the page" do
      click_link "Modules"
      current_url.should =~ %r(^http://[^/]+/modules$)
    end

    if SiteSettings.applications_open
      scenario "sees the 'Application' link and can visit the page" do
        page.should have_content("Application")
        click_link "Application"
        current_url.should =~ %r(^http://[^/]+/apply$)
      end
    else
      scenario "doesn't see the application link and is redirected to the home when try to access the page" do
        page.should_not have_content("Application")
        visit "/apply"
        current_url.should =~ %r(^http://[^/]+/$)
      end
    end

    scenario "sees the log in link" do
      page.should have_content("Student log in")
    end

    scenario "doesn't see the log out link" do
      page.should_not have_content("Log out")
    end
  end

  context "which is selected" do
    background { @user = selected_user }

    scenario "create his account by setting his password and access the program for the year he's selected" do
      visit "/users/password/edit?reset_password_token=#{@user.reset_password_token}"

      current_url.should =~ %r(^http://[^/]+/users/password/edit\?reset_password_token=#{@user.reset_password_token}$)
      page.should have_content("Set my password")

      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"

      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content(I18n.t('devise.passwords.updated'))
    end
  end

  context "which is selected and has his account created" do
    background do
      @user = selected_with_password_user
    end

    scenario "logs in" do
      visit "/"
      click_link "Student log in"

      current_url.should =~ %r(^http://[^/]+/users/login$)
      fill_in 'Email',    :with => @user.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'

      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content("#{@user.first_name} #{@user.last_name}")
      page.should have_content(I18n.t('devise.sessions.signed_in'))
    end

    pending "resets his password" do
      visit "/"
      click_link "Student log in"
      click_link "Forgot your password?"

      current_url.should =~ %r(^http://[^/]+/users/password/new$)
      page.should have_content("Forgot your password?")
      fill_in "Email", :with => @user.email
      click_button "Send"
      page.should have_content(I18n.t('devise.passwords.send_instructions'))

      visit "/users/password/edit?reset_password_token=#{@user.reset_password_token}"
      page.should have_content("Set my password")

      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"

      page.should have_content(I18n.t('devise.passwords.updated'))
      current_url.should =~ %r(^http://[^/]+/schedule$)
    end
  end

  context "which is selected, has his account created and is logged in" do
    background do
      sign_in_as_user
    end

    scenario "sees the 'Schedule' link and can visit the page" do
      page.should have_content("Schedule")
      click_link "Schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)
    end

    scenario "doesn't see the application link and is redirected to the schedule page when try to access the page" do
      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_no_content("Application")
      visit "/apply"
      page.should have_no_content(I18n.t('devise.applications.applications_closed'))
      current_url.should =~ %r(^http://[^/]+/schedule$)
    end

    scenario "doesn't see the log in link" do
      page.should have_no_content("Student log in")
    end

    scenario "sees the log out link" do
      page.should have_content("Log out")
    end

    scenario "changes his password" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)

      click_link "#{@current_user.first_name} #{@current_user.last_name}"

      current_url.should =~ %r(^http://[^/]+/user_account/edit$)
      page.should have_content("Edit my information")

      fill_in "New password",     :with => "654321"
      fill_in "Current password", :with => "123456"
      click_button "Update my credentials"

      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content(I18n.t('devise.registrations.updated'))

      sign_out
      visit "/"
      click_link "Student log in"

      current_url.should =~ %r(^http://[^/]+/users/login$)
      fill_in 'Email',    :with => @current_user.email
      fill_in 'Password', :with => '654321'
      click_button 'Log in'

      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content("#{@current_user.first_name} #{@current_user.last_name}")
      page.should have_content(I18n.t('devise.sessions.signed_in'))
    end

    scenario "sees only his year of selection" do
      @current_user.update_attribute(:year, 2010)

      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)

      page.should have_content("2010 Course Schedule")
    end

    scenario "doesn't see the 'Change year' form" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)

      page.should_not have_selector("#change_year")
    end

    scenario "logs out" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)
      visit "/schedule"
      click_link "Log out"

      current_url.should =~ %r(^http://[^/]+/$)
      page.should_not have_content("#{@current_user.first_name} #{@current_user.last_name}")
      page.should have_content(I18n.t('devise.sessions.signed_out'))
      page.should have_content("Student log in")
    end
  end

end
