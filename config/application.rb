require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Mintt
  class Application < Rails::Application
    # Add additional load paths for your own custom dirs
    config.autoload_paths += %W[#{config.root}/lib]
    # Dir["#{config.root}/lib/{}/**/*.rb"].each do |f|
    #   dir = File.expand_path(File.dirname(f))
    #   config.autoload_paths += [dir] if config.autoload_paths.exclude?(dir)
    # end
    
    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.orm                 :mongoid
      g.template_engine     :haml
      g.integration_tool    :rspec
      g.test_framework      :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
    
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    
    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end