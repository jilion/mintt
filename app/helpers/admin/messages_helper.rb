module Admin::MessagesHelper
  
  def messages_sort_parameters(field)
    sort_parameters(field).merge(:trashed => params[:trashed])
  end
  
  def show_message_title(message)
    "#{message.trashed? ? 'Trashed m' : 'M'}essage: From #{message.sender_email} received #{time_ago_in_words(message.created_at, true)} ago"
  end
  
  def message_sender_name_with_email(message)
    "#{message.sender_name} <#{message.sender_email}>" unless message.nil?
  end
  
  def sender_name_with_email_and_mailto(message, encode = 'hex', body = '')
    "#{message.sender_name} (#{mail_to(message.sender_email, nil, :encode => encode, :body => body, :class => "link")})".html_safe  unless message.nil?
  end
  
  def message_content(message)
    message.content.gsub(/\r\n/, '<br />').html_safe unless message.nil?
  end
  
  def back_to_inbox_or_trash(message)
    return if message.nil?
    message.trashed? ? link_to('Back to trash', trashes_admin_messages_path) : link_to('Back to inbox', admin_messages_path)
  end
  
end