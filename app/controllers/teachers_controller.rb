class TeachersController < ApplicationController
  before_filter :authenticate_teacher!
  
  # PUT /users/1
  def update
    @teacher = Teacher.find(current_teacher.id)
    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to edit_teacher_registration_path, :notice => "Your name has been updated." }
      else
        format.html { render 'registrations/edit' }
      end
    end
  end
  
end