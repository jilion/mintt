require 'spec_helper'

describe Teachers::RegistrationsController do
  include Devise::TestHelpers

  context "with logged-in teacher" do
    let(:teacher) { create(:teacher) }
    before do
      request.env['devise.mapping'] = Devise.mappings[:teacher]
      sign_in teacher
    end

    it "responds with redirect to PUT :update successful" do
      Teacher.should_receive(:find).and_return(teacher)
      teacher.should_receive(:update_attributes) { true }

      put :update, :teacher => {}
      flash[:notice].should eq I18n.t('devise.registrations.updated')
      flash[:alert].should be_nil
      response.should redirect_to(edit_teacher_path)
    end

    it "responds with success to PUT :update unsuccessful" do
      Teacher.should_receive(:find).and_return(teacher)
      teacher.should_receive(:update_attributes) { false }

      put :update, :teacher => {}
      flash[:notice].should be_nil
      flash[:alert].should be_nil
      response.should render_template('devise/registrations/edit')
    end
  end

end
