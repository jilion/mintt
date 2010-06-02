require 'spec_helper'

describe TeachersController do
  include Devise::TestHelpers
  
  # =======
  # = get =
  # =======
  describe :get => :index do
    before(:each) do
      @teacher = Teacher.send_invitation(:email => "test@test.com")
      Teacher.accept_invitation!(:invitation_token => @teacher.invitation_token, :password => '123456', :password_confirmation => '123456')
      @teacher.reload
      sign_in @teacher
    end
    
    it { should render_template 'teachers/index.html.haml' }
  end
  
end