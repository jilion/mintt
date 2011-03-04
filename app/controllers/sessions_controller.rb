class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "new")
    if (resource_name == :user && resource.selected?) || resource_name == :teacher
      set_flash_message :notice, :signed_in
      sign_in_and_redirect(resource_name, resource)
    else
      set_flash_message :alert, :not_allowed_to_sign_in
      redirect_to root_path
    end
  end

end
