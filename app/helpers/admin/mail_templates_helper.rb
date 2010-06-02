module Admin::MailTemplatesHelper
  
  def mail_template_title(mail_template)
    return "" if mail_template.blank?
    mail_template.title.titleize
  end
  
  def fake_resource_for(template)
    case template.title
    when /user/
      User.new(:first_name => "Steve", :last_name => "Jobs", :email => "steve@apple.com", :phone => "+41 65 787 25 23", :school => "Apple University", :lab => "Cupertino Infinite Loop", :url => "http://apple.com", :linkedin_url => "http://us.linkedin.com/stevejobs", :thesis_supervisor => "Bill Gates", :thesis_subject => "lorem ipsum...", :thesis_registration_date => 120.days.ago, :thesis_admission_date => 5.days.ago, :thesis_invention => "lorem ipsum...", :motivation => "lorem ipsum...", :confirmation_token => "ddjnwh873r3rnjmd0jdmmniu", :reset_password_token => "ddjnwh873r3rnjmd0jdmmniu")
    when /teacher/
      Teacher.new(:email => "steve@apple.com", :invitation_token => "ddjnwh873r3rnjmd0jdmmniu")
    end
  end
  
end