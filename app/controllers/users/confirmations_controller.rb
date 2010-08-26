class Users::ConfirmationsController < Devise::ConfirmationsController
  
  # GET /users/confirm?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    set_flash_message :notice, :confirmed if resource.errors.empty?
    redirect_to root_url
  end
  
end