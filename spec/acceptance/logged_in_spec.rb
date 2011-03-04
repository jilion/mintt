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

def warden
  request.env['warden']
end

def invited_teacher(options={})
  teacher = Teacher.invite(:email => "test@test.com")
  teacher
end

def invited_with_password_teacher(options={})
  teacher = invited_teacher(options)
  Teacher.accept_invitation(:invitation_token => teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
  teacher
end

def sign_in_as_teacher(options={}, &block)
  @current_teacher ||= begin
    teacher = invited_with_password_teacher(options)
    visit "/teachers/login"
    fill_in 'Email',    :with => teacher.email
    fill_in 'Password', :with => '123456'
    check   'Remember me' if options[:remember_me] == true
    yield if block_given?
    click_button 'Log in'
    teacher
  end
end
