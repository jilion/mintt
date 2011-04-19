class TeachersController < ApplicationController
  respond_to :html

  before_filter :authenticate_teacher!

  # PUT /teachers/1
  def update
    @teacher = Teacher.find(current_teacher.id)

    respond_with(@teacher) do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to edit_teacher_registration_path, :notice => t('devise.registrations.updated') }
      else
        format.html { render 'devise/registrations/edit' }
      end
    end
  end

end
