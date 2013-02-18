module ApplicationHelper

  def current_year
    @current_year ||= SiteSettings.course_dates.respond_to?("year_#{Time.now.utc.year}") ? Time.now.utc.year : Time.now.utc.year - 1
  end

  def display_date(date)
    date.blank? ? "" : l(date.to_date, :format => :lite)
  end

  def display_date_and_time(date)
    date.blank? ? "" : l(date.to_date, :format => :full)
  end

  def sexy_date(date)
    return '' if date.blank?

    if date.today?
      "Today"
    elsif date.to_time > 2.days.until(Time.now.utc)
      "Yesterday"
    else
      l(date.to_date, :format => :lite)
    end
  end

  def sexy_time(date)
    return '' if date.blank?

    l(date.utc, :format => :time)
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
