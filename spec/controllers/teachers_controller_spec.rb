require 'spec_helper'

describe TeachersController do
  include Devise::TestHelpers

  context "with logged-in teacher" do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:teacher]
      sign_in mock_teacher(:authenticatable_salt => '123456')
    end

    it "should respond with redirect to PUT :update successful" do
      Teacher.should_receive(:find).twice.and_return(mock_teacher)
      mock_teacher.should_receive(:update_attributes) { true }

      put :update, :teacher => {}
      flash[:notice].should == I18n.t('devise.registrations.updated')
      flash[:alert].should be_nil
      response.should redirect_to(edit_teacher_registration_path)
    end

    it "should respond with success to PUT :update unsuccessful" do
      Teacher.should_receive(:find).twice.and_return(mock_teacher)
      mock_teacher.should_receive(:update_attributes) { false }

      put :update, :teacher => {}
      flash[:notice].should be_nil
      flash[:alert].should be_nil
      response.should be_success
      response.should render_template('devise/registrations/edit')
    end
  end

end
