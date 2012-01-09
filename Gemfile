source :rubygems

gem 'rails', '3.0.11'

# Internals
gem 'state_machine', '1.0.1'
gem 'SystemTimer',   '1.2.3'

# Utils
gem 'settingslogic', '2.0.6'
gem 'fastercsv',     '1.5.4'
gem 'mime-types',    '1.16'

# Database
gem 'bson_ext', '1.3.1'
gem 'mongoid',  '2.0.2'

# Auth / invitations
gem 'devise',           '1.3.4'
gem 'devise_invitable', '0.5.0'

# Views
gem 'haml',          '3.1.1'
gem 'formtastic',    '1.2.4'
gem 'will_paginate', '3.0.pre2'
gem 'liquid'

group :production do
  gem 'rack-ssl-enforcer',     '0.2.2'
  gem 'rack-google-analytics', '0.9.2', :require => 'rack/google-analytics'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.6'
end

group :development do
  gem 'capistrano'
  gem 'ffaker'

  gem 'ruby_gntp'
  platforms :ruby do
    gem 'rb-readline'
  end

  gem 'guard-bundler'
  gem 'guard-pow'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-livereload'
end

group :test do
  gem 'spork', '0.9.0.rc9'

  gem 'shoulda'
  gem 'capybara'

  gem 'database_cleaner'
  gem 'factory_girl_rails', :require => false # loaded in spec_helper Spork.each_run
end
