require 'spec_helper'

describe ProgramsController do
  include Devise::TestHelpers
  
  context "as a student" do
    # =======
    # = get =
    # =======
    describe :get => :index do
      before :each do
        @user = Factory(:user)
        @user.confirm!
        sign_in @user
      end
      
      it { should render_template 'programs/index.html.haml' }
    end
  end
  
  context "as a teacher" do
    # =======
    # = get =
    # =======
    describe :get => :index do
      before :each do
        @teacher = Teacher.send_invitation(:email => "test@test.com")
        Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
        @teacher.reload
        sign_in @teacher
      end
      
      it { should render_template 'programs/index.html.haml' }
    end
  end
  
  context "as a guest" do
    # =======
    # = get =
    # =======
    describe :get => :index do
      it { should redirect_to new_user_session_url(:host => 'test.host', :unauthenticated => true) }
    end
  end
  
end