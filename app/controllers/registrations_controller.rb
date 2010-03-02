class RegistrationsController < ApplicationController
  include Devise::Controllers::InternalHelpers

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
end