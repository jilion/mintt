module CustomDevisePaths
  def after_update_path_for(resource)
    send "edit_#{resource.class.to_s.underscore}_registration_path"
  end
  def after_sign_in_path_for(resource)
    '/program'
  end
end