require File.dirname(__FILE__) + '/acceptance_helper'

feature "Applications" do
  
  background do
    ActionMailer::Base.deliveries.clear
    visit '/'
    click_link "registration_button" if APPLICATIONS_OPEN
  end
  
  it "should not display link to application if applications are closed" do
    unless APPLICATIONS_OPEN
      page.should_not have_css('#registration_button')
    end
  end
  
  it "should be possible to register and deliver confirmation email" do
    if APPLICATIONS_OPEN
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
      select_date "April 2, 2010",               :from => "Thesis registration date", :id_prefix => 'user_thesis_registration_date'
      select_date "April 26, 2010",              :from => "Thesis admission date", :id_prefix => 'user_thesis_admission_date'
      choose "user_supervisor_authorization_yes"
      choose "user_doctoral_school_rules_yes"
      fill_in "user_thesis_invention",           :with => "The iPad"
      fill_in "user_motivation",                 :with => "Huge!"
      check "user_agreement"
      click_button "Apply"
      
      current_url.should =~ %r(^http://[^/]+/modules$)
      page.should have_content('Thanks for your submission. For security purpose you will receive an email with instructions about how to confirm your application in a few minutes.')
      ActionMailer::Base.deliveries.size.should == 1
    end
  end
  
  it "should have errors with incomplete dates" do
    if APPLICATIONS_OPEN
      choose "user_gender_male"
      fill_in "user_first_name",        :with => "Joe"
      fill_in "user_last_name",         :with => "Blow"
      fill_in "user_school",            :with => "Computer Science"
      fill_in "user_lab",               :with => "Apple Lab"
      fill_in "user_email",             :with => "remy@jilion.com"
      fill_in "user_phone",             :with => "0 21 000 00 00"
      fill_in "user_url",               :with => "http://jilion.com"
      fill_in "user_linkedin_url",      :with => "http://fr.linkedin.com/in/remycoutable"
      fill_in "user_thesis_supervisor", :with => "Remy Coutable"
      fill_in "user_thesis_subject",    :with => "Advanced Compilation for Mac"
      select "Year",                    :from => "user_thesis_registration_date_1i"
      select "Month",                   :from => "user_thesis_registration_date_2i"
      select "Day",                     :from => "user_thesis_registration_date_3i"
      select "2012",                    :from => "user_thesis_admission_date_1i"
      select "Month",                   :from => "user_thesis_admission_date_2i"
      select "5",                       :from => "user_thesis_admission_date_3i"
      choose "user_supervisor_authorization_yes"
      choose "user_doctoral_school_rules_yes"
      fill_in "user_thesis_invention",  :with => "The iPad"
      fill_in "user_motivation",        :with => "Huge!"
      check "user_agreement"
      click_button "Apply"
      
      page.should have_content('please enter a valid date')
      ActionMailer::Base.deliveries.size.should == 0
    end
  end
  
  it "should not have errors with complete dates or no set date" do
    if APPLICATIONS_OPEN
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
      select "Year",                             :from => "user_thesis_registration_date_1i"
      select "Month",                            :from => "user_thesis_registration_date_2i"
      select "Day",                              :from => "user_thesis_registration_date_3i"
      select "2012",                             :from => "user_thesis_admission_date_1i"
      select "January",                          :from => "user_thesis_admission_date_2i"
      select "5",                                :from => "user_thesis_admission_date_3i"
      choose "user_supervisor_authorization_yes"
      choose "user_doctoral_school_rules_yes"
      fill_in "user_thesis_invention",           :with => "The iPad"
      fill_in "user_motivation",                 :with => "Huge!"
      check "user_agreement"
      click_button "Apply"
      
      page.should have_content('please enter a valid date')
      current_url.should =~ %r(^http://[^/]+/$)
      ActionMailer::Base.deliveries.size.should == 1
    end
  end
  
end