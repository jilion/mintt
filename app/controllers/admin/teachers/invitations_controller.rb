class Admin::Teachers::InvitationsController < Devise::InvitationsController
  before_filter :admin_required
  layout 'admin'

  # POST /resource/invitation
  def create
    self.resource = resource_class.invite!(params[resource_name], current_inviter)

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions, :email => self.resource.email
      redirect_to [:admin, :teachers] # we don't want to redirect the admin to /schedule
    else
      render_with_scope :new
    end
  end

end

module DeviseInvitable::Controllers::Helpers
  protected
  def authenticate_inviter!
    # do nothing
  end
end
