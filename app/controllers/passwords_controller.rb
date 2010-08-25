class PasswordsController < Devise::PasswordsController
  
  # POST /resource/password
  def create
    resource = resource_class.find_or_initialize_with_error_by(:email, params[resource_name][:email], :not_found)
    
    if resource.errors.present?
      render_with_scope :new
    else
      if resource.persisted? && ((resource_name == :user && resource.selected?) || resource_name != :user)
        resource.send_reset_password_instructions
        set_flash_message :notice, :send_instructions
      else
        set_flash_message :error, :cant_send_instructions
      end
      redirect_to new_session_path(resource_name)
    end
  end
  
end