bundle_path "vendor/bundler_gems"
clear_sources
source "http://gemcutter.org"
source "http://gems.github.com"

gem 'rails', '2.3.5'
gem 'warden'
gem 'devise'
gem 'haml'
gem 'formtastic'
gem 'will_paginate'

only :test do
  gem 'ruby-debug'
  gem 'rspec-rails', '1.3.2'
  gem 'cucumber-rails', '0.2.4'
  gem 'remarkable_rails', '3.1.11'
  gem 'capybara', '0.3.0'
  # gem 'random_data', '1.5.0'
  # gem 'machinist', '1.0.6'
  # gem 'shoulda', '2.10.2'
  # gem 'faker', '0.3.1'
  # gem 'webrat', '0.6.0'
end

only :production do
  # gem 'fastthread', '1.0.7'
end

