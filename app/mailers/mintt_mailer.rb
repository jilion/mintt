class MinttMailer < ActionMailer::Base
  default :from => SiteSettings.mintt_sender, :content_type => "text/plain"
  
  def new_message(message)
    @message = message
    mail(:to => SiteSettings.new_message_recipients, :reply_to => @message.sender_email, :subject => I18n.t(:new_contact_message))
  end
  
  def sign_up_instructions(user)
    @user = user
    mail(:to => @user.email, :subject => I18n.t('devise.mailer.sign_up_instructions.user_subject'))
  end
  
end