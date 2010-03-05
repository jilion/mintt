require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] = "test"

Spork.prefork do
  require File.dirname(__FILE__) + "/../config/environment"
  
  # require 'spec'
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
  require File.dirname(__FILE__) + "/factories"
  # Spec Helpers
  Dir[File.join(File.dirname(__FILE__), "spec_helpers", '*.rb')].each { |file| require file }
  
  Spec::Runner.configure do |config|
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    
    config.after(:each) do
      MongoMapper.database.collections.each { |c| c.remove }
      MailTemplate.create(:title => 'new_message', :content => "{{user.first_name}} {{user.last_name}}<{{user.email}}>\n\nThat\'s a demo template!\n\n{{confirmation_link}}")
    end
  end
  
  # Integration
  Webrat.configure do |config|
    config.mode = :rails
    config.open_error_files = false
  end
  
end