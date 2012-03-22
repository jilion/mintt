Mintt::Application.configure do
  config.middleware.use(Rack::SslEnforcer, :only => [%r(/admin), %r(/contact), %r(/schedule),
                                                     %r(/apply), %r(/users), %(/user_account),
                                                     %r(/invitation), %r(/teachers), %(/teacher_account)])
  config.middleware.use(Rack::GoogleAnalytics, :tracker => 'UA-10280941-6')
  
  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true
  
  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  
  # See everything in the log (default is :info)
  # config.log_level = :debug
  
  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new
  
  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  
  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"
  
  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  
  # Enable threaded mode
  # config.threadsafe!
  
  config.action_mailer.perform_deliveries    = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options   = { :host => "mintt.epfl.ch" }
  
  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings   = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => 'mintt@mintt.ch',
    :password             => 'Au0f2ehSbMDx',
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Choose the compressors to use
  config.assets.js_compressor  = :uglifier
  # config.assets.css_compressor = :yui

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w[admin.js admin.css print.css]

end