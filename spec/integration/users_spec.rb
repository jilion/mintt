require 'spec_helper'

describe "User" do
  
  context "has been selected" do
    before(:each) { @user = selected_user }
    
    it "should be able to set his password and access his program when he's been selected" do
      visit edit_user_password_url(:reset_password_token => @user.reset_password_token)
      
      current_url.should =~ %r(http://[^/]+/users/password/edit\?reset_password_token=#{@user.reset_password_token})
      response.should contain 'Set my password'
      
      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password"
      
      current_url.should =~ %r(http://[^/]+/program)
      flash[:success].should contain "Your password has been changed. You are now logged in."
    end
  end
  
  context "is selected and has set his password" do
    before(:each) { @user = selected_with_password_user }
    
    it "should be able to log in" do
      visit "/"
      click_link "Student log in"
      
      current_url.should == "/users/login"
      fill_in 'Email',    :with => @user.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'
      
      current_url.should =~ %r(http://[^/]+/program)
      response.should contain "#{@user.first_name} #{@user.last_name}"
      flash[:success].should contain "Logged in successfully."
    end
  end
  
  context "is logged in" do
    before(:each) { sign_in_as_user }
    
    it "should be able to change his password" do
      visit "/program"
      current_url.should == "/program"
      
      click_link "#{@current_user.first_name} #{@current_user.last_name}"
      
      current_url.should == "/users/edit"
      response.should contain "Edit my information"
      
      fill_in "Password",              :with => "654321"
      fill_in "Current password",      :with => "123456"
      click_button "Update my information"
      
      current_url.should =~ %r(http://[^/]+/users/edit)
      
      flash[:success].should contain "Your personal information has been updated."
    end
    
    it "should be able to log out" do
      pending
      visit "/program"
      current_url.should == "/program"
      visit "/program"
      click_link "Student log out"
      
      current_url.should =~ %r(http://[^/]+/)
      response.should_not contain "#{@current_user.first_name} #{@current_user.last_name}"
      response.should contain "Student log in"
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
