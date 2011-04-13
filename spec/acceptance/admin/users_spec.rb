require 'spec_helper'

feature "Admin users index" do
  background do
    ActionMailer::Base.deliveries.clear
    @user = Factory(:user)
    visit '/admin'
  end

  it "should be possible to list confirmed users" do
    ActionMailer::Base.deliveries.size.should == 1

    click_link "Students"

    current_url.should =~ %r(^http://[^/]+/admin/users$)
    page.should have_content("2011 Students")
    page.should have_css("tr", :count => 1)

    @user.confirm!

    click_link "Students"

    page.should have_content("2011 Students")

    page.should have_css("tr#user_#{@user.id}")
    page.should have_css("tr", :count => 2)
  end
end

feature "Admin users edit" do
  background do
    @user = Factory(:user)
    @user.confirm!
    ActionMailer::Base.deliveries.clear
    visit '/admin/users'
  end

  it "should be possible to select a user to participate in the program, and send him a message" do
    ActionMailer::Base.deliveries.should be_empty
    within("#user_#{@user.id}") do
      click_link "edit"
    end

    current_url.should =~ %r(^http://[^/]+/admin/users/#{@user.id}/edit$)
    page.should have_content("Edit student: #{@user.first_name} #{@user.last_name}")

    check 'user_state'
    click_button "Update student"

    current_url.should =~ %r(^http://[^/]+/admin/users$)

    @user.reload
    @user.should be_selected
    @user.selected_at.should be_present
    @user.reset_password_token.should be_present

    ActionMailer::Base.deliveries.size.should == 1
  end
end
