class Users::ApplicationsController < Devise::RegistrationsController
  prepend_before_filter do |controller|
    unless SiteSettings.applications_open
      set_flash_message :alert, :applications_closed
      redirect_to root_url
    end
  end
  
  prepend_before_filter :only => [:new, :create] do |controller|
    redirect_to after_sign_in_path_for(resource) if controller.teacher_signed_in? || controller.user_signed_in?
  end

  # POST /resource/register
  def create
    build_resource
    if resource.save
      set_flash_message :notice, :send_instructions
      redirect_to root_url
    else
      render_with_scope :new
    end
  end

end
