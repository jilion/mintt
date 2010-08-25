class Users::RegistrationsController < Devise::RegistrationsController
  include Devise::Controllers::InternalHelpers
  
  prepend_before_filter :require_no_authentication, :only => [:new, :create]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  
  def new
    unless APPLICATIONS_OPEN
      set_flash_message :error, :applications_closed
      redirect_to root_url
    end
  end
  
  # POST /resource/register
  def create
    if APPLICATIONS_OPEN
      build_resource
      if resource.save
        set_flash_message :notice, :send_instructions
        redirect_to root_url
      else
        render_with_scope :new
      end
    else
      set_flash_message :error, :applications_closed
      redirect_to root_url
    end
  end
  
protected
  
  # Authenticates the current scope and gets a copy of the current resource.
  # We need to use a copy because we don't want actions like update changing
  # the current user in place.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!")
    self.resource = resource_class.find(send(:"current_#{resource_name}").id)
  end
  
end