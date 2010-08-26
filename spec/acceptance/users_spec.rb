require File.dirname(__FILE__) + '/acceptance_helper'

feature "User" do
  
  context "has been selected" do
    background { @user = selected_user }
    
    it "should be able to set his password and access his program when he's been selected" do
      visit "/users/password/edit?reset_password_token=#{@user.reset_password_token}"
      
      current_url.should =~ %r(^http://[^/]+/users/password/edit\?reset_password_token=#{@user.reset_password_token}$)
      page.should have_content("Set my password")
      
      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"
      
      current_url.should =~ %r(^http://[^/]+/program$)
      page.should have_content("Your password has been changed. You are now logged in.")
    end
  end
  
  context "is selected and has set his password" do
    background { @user = selected_with_password_user }
    
    it "should be able to log in" do
      visit "/"
      click_link "Student log in"
      
      current_url.should =~ %r(^http://[^/]+/users/login$)
      fill_in 'Email',    :with => @user.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'
      
      current_url.should =~ %r(^http://[^/]+/program$)
      page.should have_content("#{@user.first_name} #{@user.last_name}")
      page.should have_content("Logged in successfully.")
    end
  end
  
  context "is logged in" do
    background { sign_in_as_user }
    
    it "should be able to change his password" do
      visit "/program"
      current_url.should =~ %r(^http://[^/]+/program$)
      
      click_link "#{@current_user.first_name} #{@current_user.last_name}"
      
      current_url.should =~ %r(^http://[^/]+/user_account/edit$)
      page.should have_content("Edit my information")
      
      fill_in "New password",         :with => "654321"
      fill_in "Current password", :with => "123456"
      click_button "Update my credentials"
      
      current_url.should =~ %r(^http://[^/]+/user_account/edit$)
      
      page.should have_content("Your personal information has been updated.")
    end
    
    it "should be able to log out" do
      visit "/program"
      current_url.should =~ %r(^http://[^/]+/program$)
      visit "/program"
      click_link "Log out"
      
      current_url.should =~ %r(^http://[^/]+/$)
      page.should_not have_content("#{@current_user.first_name} #{@current_user.last_name}")
      page.should have_content("Student log in")
    end
    
  end
  
end

def warden
  request.env['warden']
end

def user_application(options={})
  user = Factory(:user, options[:user] || {})
  user.confirm! unless options[:confirm] == false
  user
end

def selected_user(options={})
  user = user_application(options)
  user.update_attributes(:state => 'selected')
  user
end

def selected_with_password_user(options={})
  user = selected_user(options)
  user.password = '123456'
  user.password_confirmation = '123456'
  user.save
  user
end

def sign_in_as_user(options={}, &block)
  @current_user ||= begin
    user = selected_with_password_user(options)
    visit "/users/login"
    fill_in 'Email',    :with => user.email
    fill_in 'Password', :with => '123456'
    check   'Remember me' if options[:remember_me] == true
    yield if block_given?
    click_button 'Log in'
    user
  end
end
