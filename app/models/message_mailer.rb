class MessageMailer < ActionMailer::Base
  
  def new_message(message)
    recipients NEW_MESSAGE_RECIPIENT
    from       MINTT_SENDER
    sent_on      Time.now
    content_type "text/html"
    subject    I18n.t(:new_message_contact)
    body       :message => message
  end
  
end
