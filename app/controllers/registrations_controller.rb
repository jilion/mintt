class RegistrationsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  
  before_filter :ensure_keys_exists
  
  # POST /resource/register
  def create
    build_resource
    
    if resource.save
      flash[:success] = t("devise.confirmations.send_instructions")
      redirect_to root_url
    else
      render_with_scope :new
    end
  end
  
private
  def ensure_keys_exists
    object_name = controller_name.singularize
    params[resource_name].slice(*User.keys.keys) if params[resource_name]
  end
  
end