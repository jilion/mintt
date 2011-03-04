require 'spec_helper'

describe TeachersController do
  include Devise::TestHelpers

  context "with logged-in teacher" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:teacher]
      sign_in mock_teacher
    end

    it "should respond with redirect to PUT :update successful" do
      Teacher.stub(:find).and_return(mock_teacher)
      mock_teacher.stub(:update_attributes).and_return(true)
      put :update, :teacher => {}
      response.should redirect_to(edit_teacher_registration_path)
    end

    it "should respond with success to PUT :update unsuccessful" do
      Teacher.stub(:find).and_return(mock_teacher)
      mock_teacher.stub(:update_attributes).and_return(false)
      put :update, :teacher => {}
      response.should be_success
      response.should render_template('devise/registrations/edit')
    end
  end

end
