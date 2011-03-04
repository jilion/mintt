class SiteSettings < Settingslogic
  source "#{Rails.root}/config/site_settings.yml"
  namespace Rails.env
end
