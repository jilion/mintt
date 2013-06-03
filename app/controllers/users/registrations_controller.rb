class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :only => [:new, :create] do |controller|
    unless SiteSettings.applications_open
      set_flash_message :alert, :applications_closed
      redirect_to root_url
    end
  end

  prepend_before_filter :only => [:new, :create] do |controller|
    redirect_to after_sign_in_path_for(resource) if controller.teacher_signed_in? || controller.user_signed_in?
  end

protected

  def after_update_path_for(resource)
    program_path
  end

end
