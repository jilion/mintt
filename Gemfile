source :rubygems

gem 'rails', '3.2.12'

# Internals
gem 'state_machine'

# Utils
gem 'settingslogic'
gem 'fastercsv',     '1.5.5'
gem 'mime-types',    '1.21'

# Database
gem 'bson_ext', '~> 1.8.2'
gem 'bson',     '~> 1.8.2'
gem 'mongo',    '~> 1.8.2'
gem 'mongoid',  '~> 2.6'

# Auth / invitations
gem 'devise'
gem 'devise-encryptable'
gem 'devise_invitable'

# Views
gem 'haml'
gem 'formtastic'
gem 'will_paginate'
gem 'liquid'
gem 'rails_autolink'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'execjs'
end

group :production do
  gem 'rack-ssl-enforcer'
  gem 'rack-google-analytics'
end

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener'
end

group :tools do
  gem 'capistrano'
  gem 'ffaker'

  # Guard
  gem 'ruby_gntp'
  gem 'rb-fsevent'

  gem 'guard-pow'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-livereload'
end

group :test do
  gem 'spork', '~> 0.9.0'
  gem 'shoulda-matchers'
  gem 'capybara'

  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 1.7', :require => false # loaded in spec_helper Spork.each_run
end
