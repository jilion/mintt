module Admin::MessagesHelper
  
  def message_sender_name(message)
    message.sender_name.titleize
  end
  
  def message_sender_name_with_email(message)
    "#{message_sender_name(message)} (#{mail_to(message.sender_email, message.sender_email, :encode => "hex", :subject => 'Mintt program: ')})"
  end
  
end
