require File.dirname(__FILE__) + '/acceptance_helper'

feature "Teacher" do
  
  context "has been selected" do
    background { @teacher = invited_teacher }
    
    it "should be able to set his password and access the program when he's been invited" do
      visit "/invitation/accept?invitation_token=#{@teacher.invitation_token}"
      
      current_url.should =~ %r(^http://[^/]+/invitation/accept\?invitation_token=#{@teacher.invitation_token}$)
      page.should have_content("Set my password")
      
      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"
      
      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content("Your password has been set. You are now logged in.")
    end
  end
  
  context "is selected and has set his password" do
    background { @teacher = invited_with_password_teacher }
    
    it "should be able to log in" do
      visit "/"
      click_link "Teacher log in"
      
      current_url.should =~ %r(^http://[^/]+/teachers/login$)
      fill_in 'Email',    :with => @teacher.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'
      
      current_url.should =~ %r(^http://[^/]+/schedule$)
      page.should have_content(@teacher.email)
      page.should have_content("Logged in successfully.")
    end
  end
  
  context "is logged in" do
    background { sign_in_as_teacher }
    
    it "should be able to change his name" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)
      
      click_link @current_teacher.email
      
      current_url.should =~ %r(^http://[^/]+/teacher_account/edit$)
      page.should have_content("Edit my information")
      
      fill_in "Name", :with => 'John Doe'
      click_button "Update my name"
      
      current_url.should =~ %r(^http://[^/]+/teacher_account/edit$)
      page.should have_content(@current_teacher.reload.name)
      page.should have_content("Your name has been updated.")
    end
    
    it "should be able to log out" do
      visit "/schedule"
      current_url.should =~ %r(^http://[^/]+/schedule$)
      
      click_link "Log out"
      
      current_url.should =~ %r(^http://[^/]+/$)
      page.should_not have_content(@current_teacher.email)
      page.should have_content("Teacher log in")
    end
    
  end
  
end