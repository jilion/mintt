class RegistrationsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  
  prepend_before_filter :require_no_authentication, :only => [:new, :create]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  
  before_filter :ensure_keys_exists
  ssl_required :new, :create
  
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
        set_flash_message :success, :send_instructions
        redirect_to root_url
      else
        render_with_scope :new
      end
    else
      set_flash_message :error, :applications_closed
      redirect_to root_url
    end
  end
  
  # GET /resource/edit
  def edit
    render :edit
  end
  
  # PUT /resource
  def update
    if self.resource.update_with_password(params[resource_name])
      set_flash_message :success, :updated
      redirect_to after_update_path_for(self.resource)
    else
      render :edit
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
  
  def ensure_keys_exists
    object_name = controller_name.singularize
    params[resource_name].slice(*User.keys.keys) if params[resource_name]
  end
  
end