class ConfirmationsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm!(:confirmation_token => params[:confirmation_token])
    set_flash_message :notice, :confirmed if resource.errors.empty?
    redirect_to root_url
  end
  
end