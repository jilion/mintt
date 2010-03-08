module Admin::UsersHelper
  
  def user_gender(user)
    user.gender == 'male' ? 'M' : 'F'
  end
  
  def user_full_name(user, reverse = false)
    reverse ? "#{user.last_name} #{user.first_name}" : "#{user.first_name} #{user.last_name}".titleize
  end
  
  def user_full_name_with_email(user)
    "#{user_full_name(user)} #{mail_to(user.email, user.email, :encode => "hex", :subject => 'Mintt program: ')}"
  end
  
  def user_url(user)
    user.url? ? link_to(user.url, user.url, :onclick => "window.open(this); return false") : 'none'
  end
  
  def user_linkedin_url(user)
    user.linkedin_url? ? link_to(user.linkedin_url, user.linkedin_url, :onclick => "window.open(this); return false") : 'none'
  end
  
  def user_thesis_subject(user)
    truncate(user.thesis_subject, 50)
  end
  
  def user_motivation(user)
    truncate(user.motivation, 50)
  end
  
end