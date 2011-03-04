source :rubygems

gem 'rails',             '3.0.5'

# Internals
gem 'state_machine',         '0.9.4'

# Utils
gem 'settingslogic',         '2.0.6'
gem 'fastercsv'

# Database
gem 'bson_ext',              '1.2.4'
gem 'mongo',                 '1.2.4'
gem 'mongoid',               '~> 2.0.0.rc.7'

# Auth / invitations
gem 'devise',                '1.1.7'
gem 'devise_invitable',      :git => 'git://github.com/rymai/devise_invitable.git'

# Views
gem 'haml',                  '3.0.24'
gem 'formtastic',            '1.2.3'
gem 'will_paginate',         '3.0.pre2'
gem 'liquid'

group :production do
  gem 'rack-ssl-enforcer', '0.2.1'
  gem 'rack-google-analytics', '0.9.2', :require => 'rack/google-analytics'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'passenger'
end

group :development do
  gem 'capistrano'
  gem 'ffaker'
end

group :test do
  gem 'spork',              '~> 0.9.0.rc4'
  gem 'rb-fsevent'
  gem 'growl'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-passenger'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'livereload'
  gem 'guard-livereload'

  gem 'shoulda'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  gem 'launchy'

  gem 'factory_girl_rails', :require => false # loaded in spec_helper Spork.each_run
  gem 'database_cleaner'
end
