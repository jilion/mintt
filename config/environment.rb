RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{Rails.root}/mailers )
  
  config.gem 'devise',          :version => '1.0.7'
  config.gem 'warden',          :version => '0.10.3'
  config.gem 'haml',            :version => '2.2.24'
  config.gem 'formtastic'
  config.gem 'mongo',           :version => '>= 1.0.1', :lib => false
  config.gem 'mongo_ext',       :version => '>= 0.19.3', :lib => false
  config.gem 'mongo_mapper',    :version => '>= 0.7.5'
  config.gem 'liquid',          :version => '>= 2.0.0'
  config.gem 'will_paginate',   :version => '>= 2.3.12'
  config.gem 'comma',           :version => '>= 0.3.2'
  config.gem 'ssl_requirement', :version => '>= 0.1.0'
  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
  
  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  config.frameworks -= [:active_record]
  
  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  
  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Bern'
  
  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  
  config.action_mailer.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true,
    :user_name => 'mintt@mintt.ch',
    :password => 'Au0f2ehSbMDx'
  }
  config.action_mailer.default_charset = "utf-8"
end