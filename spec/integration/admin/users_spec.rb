require 'spec_helper'

describe "Admin users index" do
  
  before :each do
    ActionMailer::Base.deliveries = []
    @user = Factory(:user)
    visit admin_path
  end
  
  it "should be possible to list confirmed users" do
    ActionMailer::Base.deliveries.size.should == 1
    
    click_link "Students"
    
    response.should have_tag("tr", :count => 1)
    
    @user.confirm!
    
    click_link "Students"
    
    response.should have_tag("tr", :id => "#user_#{@user.id}")
    response.should have_tag("tr", :count => 2)
  end
  
end

describe "Admin users edit" do
  
  before :each do
    @user = Factory(:user)
    @user.confirm!
    ActionMailer::Base.deliveries = []
    visit admin_path
  end
  
  it "should be possible to select a user to participate in the program, and send him a message" do
    ActionMailer::Base.deliveries.should be_empty
    
    click_link "Students"
    click_link_within "#user_#{@user.id}", "edit"
    check 'user_is_selected'
    click_button "Update"
    
    response.should contain("mintt admin | Student: #{@user.first_name} #{@user.last_name}")
    
    @user.reload
    @user.selected_at.should be_present
    @user.reset_password_token.should be_present
    
    ActionMailer::Base.deliveries.size.should == 1
  end
  
end