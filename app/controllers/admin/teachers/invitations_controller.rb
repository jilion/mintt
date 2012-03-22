class Admin::Teachers::InvitationsController < Devise::InvitationsController
  include CustomDevisePaths

  before_filter :admin_required

  layout 'admin'

  def after_invite_path_for(resource_or_scope)
    case Devise::Mapping.find_scope!(resource_or_scope)
    when :teacher
      [:admin, :teachers]
    end
  end

end
