require 'spec_helper'

describe "Teacher" do
  
  context "has been selected" do
    before(:each) { @teacher = invited_teacher }
    
    it "should be able to set his password and access the program when he's been invited" do
      visit accept_teacher_invitation_url(:invitation_token => @teacher.invitation_token)
      
      current_url.should =~ %r(http://[^/]+/teachers/invitation/accept\?invitation_token=#{@teacher.invitation_token})
      response.should contain 'Set my password & create my account'
      
      fill_in "Password",              :with => "123456"
      fill_in "Password confirmation", :with => "123456"
      click_button "Set my password & create my account"
      
      current_url.should =~ %r(http://[^/]+/program)
      flash[:success].should contain "Your password has been changed. You are now logged in."
    end
  end
  
  context "is selected and has set his password" do
    before(:each) { @teacher = invited_with_password_teacher }
    
    it "should be able to log in" do
      visit "/"
      click_link "Teacher log in"
      
      current_url.should == "/teachers/login"
      fill_in 'Email',    :with => @teacher.email
      fill_in 'Password', :with => '123456'
      click_button 'Log in'
      
      current_url.should =~ %r(http://[^/]+/program)
      response.should contain @teacher.email
      flash[:success].should contain "Logged in successfully."
    end
  end
  
  context "is logged in" do
    before(:each) { sign_in_as_teacher }
    
    it "should be able to change his password" do
      visit "/program"
      current_url.should == "/program"
      
      click_link @current_teacher.email
      
      current_url.should == "/teachers/edit"
      response.should contain "Edit my information"
      
      fill_in "Name",                  :with => 'John Doe'
      fill_in "Password",              :with => "654321"
      fill_in "Password confirmation", :with => "654321"
      fill_in "Current password",      :with => "123456"
      click_button "Update"
      
      current_url.should =~ %r(http://[^/]+/program)
      @current_teacher.reload
      response.should contain @current_teacher.name
      
      flash[:success].should contain "Your personal information has been updated."
    end
    
    it "should be able to log out" do
      pending
      visit "/program"
      current_url.should == "/program"
      
      click_link "Teacher log out"
      
      current_url.should =~ %r(http://[^/]+/)
      response.should_not contain @current_teacher.email
      response.should contain "Teacher log in"
    end
    
  end
  
end

def warden
  request.env['warden']
end

def invited_teacher(options={})
  teacher = Teacher.send_invitation(:email => "test@test.com")
  teacher
end

def invited_with_password_teacher(options={})
  teacher = invited_teacher(options)
  Teacher.accept_invitation!(:invitation_token => teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
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
