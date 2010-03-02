class RegistrationsController < ApplicationController
  include Devise::Controllers::InternalHelpers

  # POST /resource/register
  def create
    build_resource

    if resource.save
      # flash[:"#{resource_name}_signed_up"] = true
      puts t('devise.confirmations.send_instructions')
      flash[:success] = @user.respond_to?(:confirm!) ? t("devise.confirmations.send_instructions") : t("devise.registrations.signed_up")
      redirect_to root_url
    else
      render_with_scope :new
    end
  end
end