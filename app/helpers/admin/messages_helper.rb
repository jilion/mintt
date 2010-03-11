module Admin::MessagesHelper
  
  def message_sender_name(message)
    message.blank? ? "" : message.sender_name.titleize
  end
  
  def message_sender_name_with_email(message)
    message.blank? ? "" : "#{message_sender_name(message)} <#{message.sender_email}>"
  end
  
  def message_sender_name_with_email_and_mailto(message, encode = 'hex', body = '')
    message.blank? ? "" : "#{message_sender_name(message)} (#{mail_to(message.sender_email, nil, :encode => encode, :body => body, :class => "link")})"
  end
  
  def message_content(message)
    message.blank? ? "" : message.content.gsub(/\r\n/, '<br />')
  end
  
  def back_to_inbox_or_trash(message)
    return "" if message.blank?
    message.trashed? ? link_to('Back to trash', trashs_admin_messages_path) : link_to('Back to inbox', admin_messages_path)
  end
  
end