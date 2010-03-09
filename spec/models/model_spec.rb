require 'spec_helper'

describe Model do
  
  # before(:each) do
  #   10.times do
  #     Factory.create(:message)
  #     params = {}
  #     params[:order_by] = 'created_at'
  #     params[:sort_way] = 'desc'
  #     @messages = Message.paginate(options.merge(:order => 'created_at desc', :per_page => Model.per_page, :page => 1))
  #   end
  # end
  # 
  # describe "default" do
  #   it "should return messages with default order when no arguments are given" do
  #     messages_with_default_arguments = Message.all_order_by
  #     
  #     @messages.should == messages_with_default_arguments
  #   end
  #   
  #   it "should return messages with default order when the sort_options keys are bad" do
  #     params = {}
  #     params[:order_by] = 'created_at'
  #     params[:sort_way] = 'desc'
  #     messages_with_bad_sort_options_keys = Message.all_order_by(params)
  #     
  #     @messages.should == messages_with_bad_sort_options_keys
  #   end
  #   
  #   it "should return messages with default order when the arguments are bad" do
  #     params = {}
  #     params[:order_by] = 'bad_created_at'
  #     params[:sort_way] = 'bad_desc'
  #     messages_with_bad_argument = Message.all_order_by(params)
  #     
  #     @messages.should_not eql(messages_with_bad_argument)
  #   end
  # end
  
end