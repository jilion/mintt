require 'spec_helper'

describe MessagesController do
  
  %w(create).each do |action|
    it "should not save non-registered attributes on #{action} action" do
      post action, :message => Factory.attributes_for(:message).merge({:not_registered_key => 'foo'}), :id => "4b8e9831d9e93410a7000001"
      params.include?(:not_registered_key).should_not be_true
    end
  end
  
end
