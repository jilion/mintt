require 'spec_helper'

describe RegistrationsController do
  
  describe :post => :create, :user => Factory.attributes_for(:user).merge({:not_registered_key => 'foo'}), :id => "4b8e9831d9e93410a7000001" do
    it { params.include?(:not_registered_key).should be_false }
  end
  
end