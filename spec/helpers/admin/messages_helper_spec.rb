require 'spec_helper'

describe Admin::MessagesHelper do

  # ==================================
  # = message_sender_name_with_email =
  # ==================================
  describe "message_sender_name_with_email" do
    describe "with nil message" do
      it "returns nothing" do
        helper.message_sender_name_with_email(nil).should be_nil
      end
    end

    describe "with a valid message" do
      it "returns the titleized mail_template's sender_name" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.message_sender_name_with_email(message).should == "#{message.sender_name} <lame@email.com>"
      end
    end
  end

  # =============================================
  # = sender_name_with_email_and_mailto =
  # =============================================
  describe "sender_name_with_email_and_mailto" do
    describe "with nil message" do
      it "returns nothing" do
        helper.sender_name_with_email_and_mailto(nil).should be_nil
      end
    end

    describe "with a valid message" do
      it "returns a beautiful string with defaults options" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.sender_name_with_email_and_mailto(message).should == "#{message.sender_name} (#{mail_to(message.sender_email, nil, :encode => 'hex', :body => '', :class => "link")})"
      end
    end

    describe "with a valid message and encode options" do
      it "returns a beautiful string with defaults options and :encode => 'foo' for the mail_to" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.sender_name_with_email_and_mailto(message, 'foo').should == "#{message.sender_name} (#{mail_to(message.sender_email, nil, :encode => 'foo', :body => '', :class => "link")})"
      end
    end

    describe "with a valid message and body options" do
      it "returns a beautiful string with defaults options and :encode => 'foo' for the mail_to" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.sender_name_with_email_and_mailto(message, nil, 'this is a body').should == "#{message.sender_name} (#{mail_to(message.sender_email, nil, :encode => nil, :body => 'this is a body', :class => "link")})"
      end
    end
  end

  # ===================
  # = message_content =
  # ===================
  describe "message_content" do
    describe "with nil message" do
      it "returns nothing" do
        helper.message_content(nil).should be_nil
      end
    end

    describe "with a valid message" do
      it "returns the message's content with \n\r replaced with <br />" do
        message = Factory(:message, :content => "this\r\nis a test\r\n\r\nmessage")
        helper.message_content(message).should == "this<br />is a test<br /><br />message"
      end
    end
  end

  # ==========================
  # = back_to_inbox_or_trash =
  # ==========================
  describe "back_to_inbox_or_trash" do
    describe "with nil message" do
      it "returns nothing" do
        helper.back_to_inbox_or_trash(nil).should be_nil
      end
    end

    describe "with a valid message" do
      it "returns a link to inbox with a non-trashed message" do
        message = Factory(:message)
        helper.back_to_inbox_or_trash(message).should == link_to('Back to inbox', admin_messages_path)
      end
    end

    describe "with a valid message" do
      it "returns a link to trashs with a trashed message" do
        message = Factory(:message, :trashed_at => Time.now.utc)
        helper.back_to_inbox_or_trash(message).should == link_to('Back to trash', admin_messages_path(:trashed => true))
      end
    end
  end

end
