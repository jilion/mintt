module Admin::MailTemplatesHelper
  
  def mail_template_title(mail_template)
    mail_template.title.titleize
  end
  
end