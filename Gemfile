source :rubygems

gem 'rails', '3.2.2'

# Internals
gem 'state_machine', '1.1.2'
gem 'SystemTimer',   '1.2.3'

# Utils
gem 'settingslogic', '2.0.8'
gem 'fastercsv',     '1.5.4'
gem 'mime-types',    '1.17.2'

# Database
gem 'bson_ext', '~> 1.6.0'
gem 'bson',     '~> 1.6.0'
gem 'mongo',    '~> 1.6.0'
gem 'mongoid',  '~>2.4.5'

# Auth / invitations
gem 'devise',           '~> 2.0.1'
gem 'devise_invitable', '~> 1.0.0'

# Views
gem 'haml',          '3.1.4'
gem 'formtastic',    '2.1.1'
gem 'will_paginate', '3.0.3'
gem 'liquid'
gem 'rails_autolink'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.0'
  gem 'coffee-rails', '~> 3.2.0'
  gem 'uglifier'
  gem 'execjs'
end

group :production do
  gem 'rack-ssl-enforcer',     '0.2.4'
  gem 'rack-google-analytics', '0.10.0', :require => 'rack/google-analytics'
end

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener', :git => 'git://github.com/pcg79/letter_opener.git' # includes a fix not merged yet
end

group :tools do
  gem 'capistrano'
  gem 'ffaker'

  gem 'growl'
  platforms :ruby do
    gem 'rb-readline'
  end

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
  gem 'factory_girl_rails', :require => false # loaded in spec_helper Spork.each_run
end
