require 'spec_helper'

describe Admin::MessagesHelper do
  
  # =======================
  # = message_sender_name =
  # =======================
  describe "message_sender_name" do
    describe "with nil message" do
      it "should return nothing" do
        helper.message_sender_name(nil).should == ''
      end
    end
    
    describe "with a valid message" do
      it "should return the titleized mail_template's sender_name" do
        helper.message_sender_name(Factory(:message, :sender_name => "lame name")).should == "Lame Name"
      end
    end
  end
  
  # ==================================
  # = message_sender_name_with_email =
  # ==================================
  describe "message_sender_name_with_email" do
    describe "with nil message" do
      it "should return nothing" do
        helper.message_sender_name_with_email(nil).should == ''
      end
    end
    
    describe "with a valid message" do
      it "should return the titleized mail_template's sender_name" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.message_sender_name_with_email(message).should == "#{helper.message_sender_name(message)} <lame@email.com>"
      end
    end
  end
  
  # =============================================
  # = message_sender_name_with_email_and_mailto =
  # =============================================
  describe "message_sender_name_with_email_and_mailto" do
    describe "with nil message" do
      it "should return nothing" do
        helper.message_sender_name_with_email_and_mailto(nil).should == ''
      end
    end
    
    describe "with a valid message" do
      it "should return a beautiful string with defaults options" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.message_sender_name_with_email_and_mailto(message).should == "#{helper.message_sender_name(message)} (#{mail_to(message.sender_email, nil, :encode => 'hex', :body => '', :class => "link")})"
      end
    end
    
    describe "with a valid message and encode options" do
      it "should return a beautiful string with defaults options and :encode => 'foo' for the mail_to" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.message_sender_name_with_email_and_mailto(message, 'foo').should == "#{helper.message_sender_name(message)} (#{mail_to(message.sender_email, nil, :encode => 'foo', :body => '', :class => "link")})"
      end
    end
    
    describe "with a valid message and body options" do
      it "should return a beautiful string with defaults options and :encode => 'foo' for the mail_to" do
        message = Factory(:message, :sender_name => "lame name", :sender_email => 'lame@email.com')
        helper.message_sender_name_with_email_and_mailto(message, nil, 'this is a body').should == "#{helper.message_sender_name(message)} (#{mail_to(message.sender_email, nil, :encode => nil, :body => 'this is a body', :class => "link")})"
      end
    end
  end
  
  # ===================
  # = message_content =
  # ===================
  describe "message_content" do
    describe "with nil message" do
      it "should return nothing" do
        helper.message_content(nil).should == ''
      end
    end
    
    describe "with a valid message" do
      it "should return the message's content with \n\r replaced with <br />" do
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
      it "should return nothing" do
        helper.back_to_inbox_or_trash(nil).should == ''
      end
    end
    
    describe "with a valid message" do
      it "should return a link to inbox with a non-trashed message" do
        message = Factory(:message)
        helper.back_to_inbox_or_trash(message).should == link_to('Back to inbox', admin_messages_path)
      end
    end
    
    describe "with a valid message" do
      it "should return a link to trashs with a trashed message" do
        message = Factory(:message, :trashed_at => Time.now)
        helper.back_to_inbox_or_trash(message).should == link_to('Back to trash', trashes_admin_messages_path)
      end
    end
  end
  
end