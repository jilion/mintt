module AdminAuthenticatedSystem
  
private
  
  def admin_required
    admin_authorized? || admin_access_denied
  end
  
  def admin_access_denied
    redirect_to root_path
  end
  
  def admin_authorized?
    admin?
  end
  
  def admin?
    admin_login_from_session || admin_login_from_cookie || admin_login_from_http
  end
  
  def admin_session?
    admin_login_from_session
  end
  
  def admin_login_from_session
    session[:auth_token] == admin_sha1
  end
  
  def admin_login_from_cookie
    if cookies[:auth_token] == admin_sha1
      set_admin_cookie_and_session
    end
  end
  
  def admin_login_from_http
    if Rails.env.production? || params[:admin_http]
      authenticate_or_request_with_http_basic do |user, pass|
        if user == admin_credential[:user] && pass == admin_credential[:pass]
          set_admin_cookie_and_session
          true
        end
      end
      # Can be removed with Rails 3: http://wiki.github.com/plataformatec/devise/devise-and-http-authentication
      warden.custom_failure! if performed?
    else
      true
    end
  end
  
  def admin_logout
    session[:auth_token] = nil
    cookies[:auth_token] = nil
  end
  
  def set_admin_cookie_and_session
    session[:auth_token] = admin_sha1
    cookies[:auth_token] = { :value => admin_sha1, :expires => 2.months.from_now.utc }
  end
  
  def admin_sha1
    Digest::SHA1.hexdigest(admin_credential[:user] + admin_credential[:pass])
  end
  
  def admin_credential
    config_path = File.join(Rails.root, 'config', "admin.yml")
    begin
      @default_storage ||= YAML::load_file(config_path)[Rails.env]
      @default_storage.to_options
    rescue
      raise StandardError, "Admin credential file '#{config_path}' doesn't exist or have right information about Rails '#{Rails.env}' environment."
    end
  end
  
end