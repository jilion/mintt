source :rubygems

gem 'bundler',    '1.0.13'
gem 'rails',      '3.0.7'

# Internals
gem 'state_machine', '0.10.4'
gem 'SystemTimer',   '1.2.3'

# Utils
gem 'settingslogic', '2.0.6'
gem 'fastercsv',     '1.5.4'
gem 'mime-types',    '1.16'

# Database
gem 'bson_ext', '1.3.0'
gem 'mongoid',  '2.0.1'

# Auth / invitations
gem 'devise',           '1.3.4'
gem 'devise_invitable', '0.5.0'

# Views
gem 'haml',          '3.1.1'
gem 'formtastic',    '1.2.3'
gem 'will_paginate', '3.0.pre2'
gem 'liquid'

group :production do
  gem 'rack-ssl-enforcer',     '0.2.2'
  gem 'rack-google-analytics', '0.9.2', :require => 'rack/google-analytics'
end

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'capistrano'
  gem 'ffaker'
end

group :test do
  gem 'rb-fsevent'
  gem 'spork', '0.9.0.rc7'
  gem 'growl'
  gem 'guard-bundler'
  gem 'guard-pow'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-livereload'

  gem 'shoulda'
  gem 'capybara', '1.0.0.beta1'

  gem 'database_cleaner'
  gem 'factory_girl_rails', :require => false # loaded in spec_helper Spork.each_run
end
