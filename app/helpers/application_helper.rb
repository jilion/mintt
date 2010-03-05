module ApplicationHelper
  
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def sexy_date(date)
    if date.today? || date.to_time > 2.days.until(Time.now)
      "#{time_ago_in_words(date)} ago"
    else
      date.strftime("%B %d, %Y")
    end
  end
  
  def words_count(text)
    return 0 if text.nil?
    count = text.split(' ').size
    "#{count} word#{"s" if count > 1}"
  end
  
end