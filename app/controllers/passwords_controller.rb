# This controller allow sending password reset instructions only to selected users (allowing them to enter access their account)
class PasswordsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  
  # POST /resource/password
  def create
    resource = resource_class.find_or_initialize_with_error_by(:email, params[resource_name][:email], :not_found)
    
    if resource.errors.present?
      render_with_scope :new
    else
      if resource.persisted? && ((resource_name == :user && resource.has_been_selected?) || resource_name != :user)
        resource.send_reset_password_instructions
        set_flash_message :success, :send_instructions
      else
        set_flash_message :error, :cant_send_instructions
      end
      redirect_to new_session_path(resource_name)
    end
  end
end
