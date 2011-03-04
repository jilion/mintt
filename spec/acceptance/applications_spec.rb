feature "Applications" do

  background do
    ActionMailer::Base.deliveries.clear
    visit '/'
    # save_and_open_page
    click_link "registration_button" if SiteSettings.applications_open
  end

  it "should not display link to application if applications are closed" do
    if SiteSettings.applications_open
      page.should have_css('#registration_button')
    else
      page.should_not have_css('#registration_button')
    end
  end

  if SiteSettings.applications_open
    it "should be possible to register and deliver confirmation email" do
      choose "user_gender_male"
      fill_in "user_first_name",                 :with => "Joe"
      fill_in "user_last_name",                  :with => "Blow"
      fill_in "user_school",                     :with => "Computer Science"
      fill_in "user_lab",                        :with => "Apple Lab"
      fill_in "user_email",                      :with => "remy@jilion.com"
      fill_in "user_phone",                      :with => "0 21 000 00 00"
      fill_in "user_url",                        :with => "http://jilion.com"
      fill_in "user_linkedin_url",               :with => "http://fr.linkedin.com/in/remycoutable"
      fill_in "user_thesis_supervisor",          :with => "Remy Coutable"
      fill_in "user_thesis_subject",             :with => "Advanced Compilation for Mac"
      select "2011",                             :from => "user_thesis_registration_date_1i"
      select "April",                            :from => "user_thesis_registration_date_2i"
      select "2",                                :from => "user_thesis_registration_date_3i"
      select "2011",                             :from => "user_thesis_admission_date_1i"
      select "April",                            :from => "user_thesis_admission_date_2i"
      select "26",                               :from => "user_thesis_admission_date_3i"
      choose "user_supervisor_authorization_yes"
      choose "user_doctoral_school_rules_yes"
      fill_in "user_thesis_invention",           :with => "The iPad"
      fill_in "user_motivation",                 :with => "Huge!"
      check "user_agreement"
      click_button "Apply"

      current_url.should =~ %r(^http://[^/]+/$)
      page.should have_content('Thanks for your submission. For security purpose you will receive an email with instructions about how to confirm your application in a few minutes.')
      ActionMailer::Base.deliveries.size.should == 1
    end

    it "should have errors with not filled fields" do
      click_button "Apply"

      page.should have_content('Choose a gender')
      ActionMailer::Base.deliveries.size.should == 0
    end
  end

end
