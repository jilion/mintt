module ApplicationHelper
  
  def title(page_title, show_title = true)
    @content_for_title      = " | #{strip_tags(page_title.to_s)}"
    @content_for_page_title = page_title.to_s.html_safe if show_title
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
  
  # If text is longer than +options[:length]+ (defaults to 30), text will be middle-truncated
  # and the last characters will be replaced with the +options[:omission]+ (defaults to "...").
  def truncate_middle(text, *args)
    options = args.extract_options!
    options.reverse_merge!(:length => 30, :omission => "...")
    
    if text
      if text.mb_chars.length <= options[:length]
        text
      else
        side_length = (options[:length]-options[:omission].mb_chars.length)/2
        text[0..side_length] + options[:omission] + text[-side_length..-1]
      end
    end
  end
  
  
end