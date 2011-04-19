require 'spec_helper'

feature "Applications" do
  background do
    ActionMailer::Base.deliveries.clear
    visit '/'
    click_link "registration_button" if SiteSettings.applications_open
  end

  if SiteSettings.applications_open
    it "registers and receives a confirmation email" do
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
      expect { click_button "Apply" }.to change(ActionMailer::Base.deliveries, :count).by(1)

      current_url.should =~ %r(^http://[^/]+/$)
      page.should have_content(I18n.t('devise.applications.send_instructions'))
      ActionMailer::Base.deliveries.size.should == 1
    end

    it "has errors when required fields not filled" do
      expect { click_button "Apply" }.to_not change(ActionMailer::Base.deliveries, :count)

      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'First name'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'Last name'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'School'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'Lab'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'Email'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'Phone'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'Thesis supervisor'))
      page.should have_content(I18n.t('mongoid.errors.messages.blank', :attribute => 'Thesis subject'))
      page.should have_content(I18n.t('mongoid.errors.models.user.attributes.motivation.blank', :attribute => 'Motivation'))
      page.should have_content(I18n.t('mongoid.errors.models.user.attributes.gender.inclusion'))
      page.should have_content(I18n.t('mongoid.errors.models.user.attributes.agreement.accepted'))
      ActionMailer::Base.deliveries.size.should == 0
    end

    it "has errors when given email is already taken" do
      Factory(:user, :email => "remy@jilion.com")

      fill_in "user_email", :with => "remy@jilion.com"
      expect { click_button "Apply" }.to_not change(ActionMailer::Base.deliveries, :count)

      page.should have_content(I18n.t('mongoid.errors.messages.taken', :attribute => 'Email'))
    end

    it "has errors with non-chronological thesis registration and admission dates" do
      Factory(:user, :email => "remy@jilion.com")

      select "2011",  :from => "user_thesis_registration_date_1i"
      select "April", :from => "user_thesis_registration_date_2i"
      select "2",     :from => "user_thesis_registration_date_3i"
      select "2010",  :from => "user_thesis_admission_date_1i"
      select "April", :from => "user_thesis_admission_date_2i"
      select "26",    :from => "user_thesis_admission_date_3i"
      expect { click_button "Apply" }.to_not change(ActionMailer::Base.deliveries, :count)

      page.should have_content(I18n.t('mongoid.errors.models.user.attributes.thesis_registration_date.after_admission_date', :attribute => 'Thesis registration date'))
    end
  end

end
