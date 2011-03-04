class TeachersController < ApplicationController
  before_filter :authenticate_teacher!

  # PUT /teachers/1
  def update
    @teacher = Teacher.find(current_teacher.id)

    if @teacher.update_attributes(params[:teacher])
      redirect_to edit_teacher_registration_path, :notice => "Your name has been updated."
    else
      render 'devise/registrations/edit'
    end
  end

end
