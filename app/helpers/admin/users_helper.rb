module Admin::UsersHelper
  
  def user_gender(user)
    return "" if user.blank?
    user.gender == 'male' ? 'M' : 'F'
  end
  
  def full_name(user, reverse = false)
    return "" if user.blank?
    (reverse ? "#{user.last_name} #{user.first_name}" : "#{user.first_name} #{user.last_name}").titleize
  end
  
  def full_name_with_email(user, reverse = false)
    user.blank? ? "" : "#{full_name(user, reverse)} #{mail_to(user.email, nil, :encode => "hex", :subject => 'Mintt program: ')}"
  end
  
  def user_url(user)
    return "" if user.blank?
    url_or_none(user.url)
  end
  
  def user_linkedin_url(user)
    return "" if user.blank?
    url_or_none(user.linkedin_url)
  end
  
  def user_thesis_subject(user)
    user.blank? ? "" : truncate(user.thesis_subject, :length => 50)
  end
  
  def user_motivation(user)
    user.blank? ? "" : truncate(user.motivation, :length => 50)
  end
  
  def user_case_study_title(user)
    return "" if user.blank?
    user.case_study_title.nil? ? "Not available" : user.case_study_title
  end
  
  def user_case_study_teacher(user)
    return "" if user.blank?
    user.case_study_teacher.nil? ? "Not available" : user.case_study_teacher
  end
  
  def user_credits_granted(user)
    return "" if user.blank?
    user.credits_granted.nil? ? "Not yet" : (user.credits_granted == 0 ? "Failed" : user.credits_granted)
  end
  
  def hide_if_selected(user)
    user.selected? ? nil : 'display:none;'
  end
  
  def male_female_for_select
    [["Mrs.", "female"], ["Mr.", "male"]]
  end
  
  def yes_no_for_select
    [["Yes", "yes"], ["No", "no"]]
  end
  
private
  def url_or_none(url)
    url.blank? ? 'none' : link_to(url, url, :onclick => "window.open(this); return false")
  end
  
end