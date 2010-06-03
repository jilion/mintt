require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] = "test"

Spork.prefork do
  require File.dirname(__FILE__) + "/../config/environment"
  
  require 'spec/rails'
  
  require 'remarkable_rails'
  # require 'remarkable/mongo_mapper'
  require "email_spec"
  
  require 'factory_girl'
  
  # Integration
  require 'webrat'
  require 'webrat/integrations/rspec-rails'
end

Spork.each_run do
  # This code will be run each time you run your specs.
  
  # Require factories file
  require File.dirname(__FILE__) + '/factories'
  
  # Requires supporting files with custom matchers and macros, etc, in ./support/ and its subdirectories.
  Dir[Rails.root.join('/spec/support/**/*.rb')].each { |f| require f; puts "require #{f}" }
  
  Spec::Runner.configure do |config|
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    # config.include(IntegrationHelper)
    
    config.after(:each) do
      MongoMapper.database.collections.each { |c| c.remove }
      MailTemplate.create(:title => 'user_application_confirmation', :content => '{{user.first_name}} {{user.last_name}} {{user.confirmation_link}}')
      MailTemplate.create(:title => 'user_sign_up', :content => '{{user.first_name}} {{user.last_name}} {{user.set_password_link}}')
      MailTemplate.create(:title => 'teacher_invitation', :content => '{{teacher.email}} {{teacher.invitation_link}}')
    end
  end
  
  # Integration
  Webrat.configure do |config|
    config.mode = :rails
    config.open_error_files = false
  end
  
end
