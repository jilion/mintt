class Users::ApplicationsController < Devise::RegistrationsController
  prepend_before_filter do |controller|
    unless APPLICATIONS_OPEN
      set_flash_message :alert, :applications_closed
      redirect_to root_url
    end
  end
  prepend_before_filter :require_no_authentication, :only => [:new, :create]
  
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