require 'spec_helper'

describe RegistrationsController do
  
  before(:each) do
    Factory.create(:mail_template)
  end
  
  %w(create).each do |action|
    it "should not save non-registered attributes on #{action} action" do
      post action, :user => Factory.attributes_for(:user).merge({:not_registered_key => 'foo'}), :id => "4b8e9831d9e93410a7000001"
      params.include?(:not_registered_key).should_not be_true
    end
  end

end
