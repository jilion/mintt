require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] = 'test'
  require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
  require 'rspec/rails'
  require 'shoulda'
  # require 'mongoid-rspec'
end

Spork.each_run do
  Dir[Rails.root.join('/spec/support/**/*.rb')].each { |f| require f }
  
  RSpec.configure do |config|
    config.include Shoulda::ActionController::Matchers
    
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
    
    config.mock_with :rspec
    
    config.before(:each) do
      Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
      MailTemplate.create(:title => 'user_application_confirmation', :content => '{{user.first_name}} {{user.last_name}} {{user.confirmation_link}}')
      MailTemplate.create(:title => 'user_invitation', :content => '{{user.first_name}} {{user.last_name}} {{user.invitation_link}}')
      MailTemplate.create(:title => 'teacher_invitation', :content => '{{teacher.email}} {{teacher.invitation_link}}')
    end
  end
end