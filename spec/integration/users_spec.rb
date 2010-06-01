require 'spec_helper'

describe "User" do
  
  context "has been selected" do
    before(:each) { @user = selected_user }
    
    it "should be able to set his password and access his dashboard when he's been selected" do
      visit edit_user_password_url(:reset_password_token => @user.reset_password_token)
      
      current_url.should =~ %r(http://[^/]+/users/password/edit\?reset_password_token=#{@user.reset_password_token})
      response.should contain 'Set my password'
      
      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"
      
      current_url.should =~ %r(http://[^/]+/dashboard)
      flash[:success].should contain "Your password has been changed. You are now logged in."
    end
  end
  
  context "is selected and has set his password" do
    before(:each) { @user = selected_with_password_user }
    
    it "should be able to log in" do
      visit "/users/login"
      
      current_url.should == "/users/login"
      fill_in 'Email',    :with => @user.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'
      
      current_url.should =~ %r(http://[^/]+/dashboard)
      response.should contain "#{@user.first_name} #{@user.last_name}"
      flash[:success].should contain "Logged in successfully."
    end
  end
  
  context "is logged in" do
    before(:each) { @user = sign_in_as_user }
    
    it "should be able to change his password" do
      visit "/dashboard"
      current_url.should == "/dashboard"
      
      click_link "#{@user.first_name} #{@user.last_name}"
      
      current_url.should == "/users/edit"
      response.should contain "Edit my information"
      
      fill_in "Password",              :with => "654321"
      fill_in "Password confirmation", :with => "654321"
      fill_in "Current password",      :with => "123456"
      click_button "Update"
      
      flash[:success].should contain "You account has been updated."
    end
    
    it "should be able to log out" do
      pending
      visit "/dashboard"
      current_url.should == "/dashboard"
      
      integration_session.should contain "Logout"
      click_link "Log out"
      
      current_url.should =~ %r(http://[^/]+/)
      response.should_not contain "#{@user.first_name} #{@user.last_name}"
      response.should contain "Log in"
      flash[:success].should contain "You are now logged out."
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
  user.select
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
