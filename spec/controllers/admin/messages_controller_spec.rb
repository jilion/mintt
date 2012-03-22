require 'spec_helper'

describe Admin::MessagesController do
  let(:message) { create(:message) }

  it "responds with success to GET :index" do
    Message.stub(:index_order_by).and_return([])
    get :index, :page => 2
    response.should render_template(:index)
  end

  it "responds with success to GET :show" do
    get :show, :id => message.id
    response.should render_template(:show)
  end

  it "trash a message and redirect to trash" do
    put :update, :id => message.id, :message => { :trashed_at => Time.now.utc }
    response.should redirect_to(trash_admin_messages_path)
    message.reload.should be_trashed
  end

  it "untrash a message and redirect to inbox" do
    message.update_attribute(:trashed_at, Time.now)
    message.should be_trashed
    put :update, :id => message.id, :message => { :trashed_at => nil }
    response.should redirect_to(inbox_admin_messages_path)
    message.reload.should_not be_trashed
  end

end
