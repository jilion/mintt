require 'spec_helper'

describe Admin::UsersController do

  before(:each) do
    Factory.create(:mail_template)
  end

  %w(update).each do |action|
    it "should not save non-registered attributes on #{action} action" do
      id = "4b8e9831d9e93410a7000001"
      User.should_receive(:find).with(id).and_return(Factory.create(:user))
      post action, :user => Factory.attributes_for(:user).merge({:not_registered_key => 'foo'}), :id => id
      params.include?(:not_registered_key).should_not be_true
    end
  end

end
