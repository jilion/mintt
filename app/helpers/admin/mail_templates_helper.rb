module Admin::MailTemplatesHelper

  def mail_template_title(mail_template)
    mail_template.title.titleize
  end
  
  # def confirmation_link(title, user)
  #   link_to(title, user_confirmation_url(:confirmation_token => user.confirmation_token))
  # end
  
end

