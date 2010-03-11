module Admin::MailTemplatesHelper
  
  def mail_template_title(mail_template)
    return "" if mail_template.blank?
    mail_template.title.titleize
  end
  
end