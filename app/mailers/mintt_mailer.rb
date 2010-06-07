class MinttMailer < ActionMailer::Base
  
  def new_message(message)
    recipients    NEW_MESSAGE_RECIPIENTS
    from          MINTT_SENDER
    reply_to      message.sender_email
    sent_on       Time.now
    content_type  "text/plain"
    subject       I18n.t(:new_contact_message)
    body          :message => message
    
    # @message = message
    # setup_mail(message, :subject => I18n.t(:new_contact_message), :to => NEW_MESSAGE_RECIPIENTS, :reply_to => message.sender_email)
  end
  
  def sign_up_instructions(user)
    recipients    user.email
    from          MINTT_SENDER
    sent_on       Time.now
    content_type  "text/plain"
    subject       I18n.t(:"devise.mailer.invitation")
    body          :user => user
    
    # @user = user
    # setup_mail(user, :subject => "Activate your student account on mintt.epfl.ch")
  end
  
  # Configure default email options
  # def setup_mail(record, options)
  #   headers = {
  #     :from => MINTT_SENDER,
  #     :to => record.email,
  #     :content_type => "text/plain"
  #   }.merge(options)
  #   
  #   mail(headers)
  # end
  
end