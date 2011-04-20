require 'spec_helper'

feature "Teacher" do

  context "which is not logged in" do
    background do
      visit "/"
    end

    scenario "sees the log in link" do
      page.should have_content("Teacher log in")
    end
  end

  context "which is invited" do
    background do
      @teacher = invited_teacher
    end

    scenario "creates his account by setting his password and access the program for the first year he's been active in" do
      visit "/invitation/accept?invitation_token=#{@teacher.invitation_token}"

      current_url.should =~ %r(^http://[^/]+/invitation/accept\?invitation_token=#{@teacher.invitation_token}$)
      page.should have_content("Set my name &amp; password")

      fill_in "Name",                  :with => "John Doe"
      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my name & password"

      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content(I18n.t('devise.invitations.updated'))
      page.should have_content("John Doe")
    end
  end

  context "which is invited and has his account created" do
    background do
      @teacher = invited_with_password_teacher
    end

    scenario "logs in" do
      visit "/"
      click_link "Teacher log in"

      current_url.should =~ %r(^http://[^/]+/teachers/login$)
      fill_in 'Email',    :with => @teacher.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'

      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content(@teacher.email)
      page.should have_content(I18n.t('devise.sessions.signed_in'))
    end

    pending "resets his password" do
      visit "/"
      click_link "Teacher log in"
      click_link "Forgot your password?"

      current_url.should =~ %r(^http://[^/]+/teachers/password/new$)
      page.should have_content("Forgot your password?")
      fill_in "Email", :with => @teacher.email
      click_button "Send"
      page.should have_content(I18n.t('devise.passwords.send_instructions'))
puts @teacher.reset_password_token
      visit "/teachers/password/edit?reset_password_token=#{@teacher.reset_password_token}"
      page.should have_content("Set my password")

      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"

      page.should have_content(I18n.t('devise.passwords.updated'))
      current_url.should =~ %r(^http://[^/]+/schedule$)
    end
  end

  context "which is invited, has his account created and is logged in" do
    background { sign_in_as_teacher }

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

    scenario "changes his name" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)

      click_link @current_teacher.email

      current_url.should =~ %r(^http://[^/]+/teacher_account/edit$)
      page.should have_content("Edit my information")

      fill_in "Name", :with => 'John Doe'
      click_button "Update my name"

      current_url.should =~ %r(^http://[^/]+/teacher_account/edit$)
      page.should have_content(@current_teacher.reload.name)
      page.should have_content(I18n.t('devise.registrations.updated'))
    end

    scenario "logs out" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)

      click_link "Log out"

      current_url.should =~ %r(^http://[^/]+/$)
      page.should_not have_content(@current_teacher.email)
      page.should have_content(I18n.t('devise.sessions.signed_out'))
      page.should have_content("Teacher log in")
    end

    context "active in only one year" do
      background { @current_teacher.update_attribute(:years, [2010]) }

      scenario "doesn't see the 'Change year' form" do
        sign_out # clear the session
        sign_in_as_teacher
        @current_teacher.years.should == [2010]

        visit "/schedule"
        current_url.should =~ %r(^http://[^/]+/schedule$)
        page.should have_content("2010 Course Schedule")
        page.should_not have_selector("#change_year")
      end
    end

    context "active in only two years" do
      background { @current_teacher.update_attribute(:years, [2010, 2011]) }

      scenario "sees the 'Change year' form" do
        sign_out # clear the session
        sign_in_as_teacher
        @current_teacher.years.should == [2010, 2011]

        visit "/schedule"
        current_url.should =~ %r(^http://[^/]+/schedule$)
        page.should have_content("2011 Course Schedule")
        page.should have_selector("#change_year")

        select "2011", :from => "year"

        page.should have_content("2011 Course Schedule")
      end
    end

  end

end
