require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu
  require "rails/mongoid"
  Spork.trap_class_method(Rails::Mongoid, :load_models)
  require "rails/application"
  Spork.trap_method(Rails::Application, :reload_routes!)

  require File.dirname(__FILE__) + "/../config/environment"
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/rails'

  RSpec.configure do |config|
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.mock_with :rspec

    config.before(:suite) do
      DatabaseCleaner[:mongoid].strategy = :truncation
      DatabaseCleaner.clean_with(:truncation) # clean all the databases
    end

    config.before(:each) do
      MailTemplate.create!(:title => 'user_application_confirmation', :content => '{{user.first_name}} {{user.last_name}} {{user.confirmation_link}}')
      MailTemplate.create!(:title => 'user_invitation', :content => '{{user.first_name}} {{user.last_name}} {{user.invitation_link}}')
      MailTemplate.create!(:title => 'teacher_invitation', :content => '{{teacher.email}} {{teacher.invitation_link}}')
      Capybara.reset_sessions!
      DatabaseCleaner.start
    end

    # Clear MongoDB Collection
    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.after(:all) do
      DatabaseCleaner.clean_with(:truncation) # clean all the databases
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

  # Factory need to be required each launch to prevent loading of all models
  require 'factory_girl'
  require Rails.root.join("spec/factories")

  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  RSpec.configure do |config|
    config.include Shoulda::ActionController::Matchers
    config.include Devise::TestHelpers, :type => :controller
  end
end
