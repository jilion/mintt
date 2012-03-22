class Teachers::RegistrationsController < Devise::RegistrationsController
  respond_to :html

  before_filter :authenticate_teacher!

  # PUT /teacher_account
  def update
    @teacher = Teacher.find(current_teacher.id)

    respond_with(@teacher) do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to edit_teacher_path, :notice => t('devise.registrations.updated') }
      else
        format.html { render 'devise/registrations/edit' }
      end
    end
  end

end
