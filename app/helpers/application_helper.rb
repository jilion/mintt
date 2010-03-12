module ApplicationHelper
  
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def display_date(date)
    date.blank? ? "" : date.to_s(:lite)
  end
  
  def display_date_and_time(date)
    date.blank? ? "" : date.to_s(:full)
  end
  
  def sexy_date(date)
    return "" if date.blank?
    if date.today?
      "Today"
    elsif date.to_time > 2.days.until(Time.now)
      "Yesterday"
    else
      date.to_s(:lite)
    end
  end
  
  def sexy_time(date)
    return "" if date.blank?
    date.to_s(:time)
  end
  
  def words_count(text)
    count = text.blank? ? 0 : text.split(' ').size
    "#{count} word#{"s" if count == 0 || count > 1}"
  end
  
end