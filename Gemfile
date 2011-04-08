source :rubygems

gem 'bundler', '1.0.11'
gem 'rails',   '3.0.6'

# Internals
gem 'state_machine', '0.9.4'
gem 'SystemTimer',   '1.2.3'

# Utils
gem 'settingslogic', '2.0.6'
gem 'fastercsv',     '1.5.4'
gem 'mime-types',    '1.16'

# Database
gem 'bson_ext', '1.3.0'
gem 'mongoid',  '2.0.0'

# Auth / invitations
gem 'devise',           '1.2.1'
gem 'devise_invitable', '0.4.1'
# gem 'devise_invitable', :git => 'git://github.com/rymai/devise_invitable.git'

# Views
gem 'haml',          '3.0.25'
gem 'formtastic',    '1.2.3'
gem 'will_paginate', '3.0.pre2'
gem 'liquid'

group :production do
  gem 'rack-ssl-enforcer',     '0.2.1'
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
  gem 'spork', '~> 0.9.0.rc4'
  gem 'rb-fsevent'
  gem 'growl'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-pow'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'livereload'
  gem 'guard-livereload'

  gem 'shoulda'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git', :ref => "218510e64f2fa8c2a2ccd3a709897be5dbfd1b93"

  gem 'database_cleaner'
  gem 'factory_girl_rails', :require => false # loaded in spec_helper Spork.each_run
end
