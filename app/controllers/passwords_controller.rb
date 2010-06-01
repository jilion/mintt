# This controller allow sending password reset instructions only to selected users (allowing them to enter access their account)
class PasswordsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  
  # GET /resource/password/new
  def new
    build_resource
    render_with_scope :new
  end
  
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
  
  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
    render_with_scope :edit
  end
  
  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(params[resource_name])
    
    if resource.errors.empty?
      set_flash_message :success, :updated
      sign_in_and_redirect(resource_name, resource)
    else
      render_with_scope :edit
    end
  end
end
