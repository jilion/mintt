class SessionsController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => [:new, :create]
  include Devise::Controllers::InternalHelpers
  
  def new
    flash[:error] = "You are not logged in." if params[:unauthenticated]
  end
  
  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "new")
    if (resource_name == :user && resource.has_been_selected?) || resource_name != :user
      set_flash_message :success, :signed_in
      sign_in_and_redirect(resource_name, resource)
    else
      set_flash_message :error, :not_allowed_to_sign_in
      redirect_to root_path
    end
  end
  
  # GET /resource/sign_out
  def destroy
    set_flash_message :success, :signed_out if signed_in?(resource_name)
    sign_out_and_redirect(resource_name)
  end
end
