module LayoutHelper

  def title_and_page_title(text, header_size = 3)
    title(text)
    page_title(text, header_size)
  end

  def title(text)
    content_for :title do
      " | #{strip_tags(text)}"
    end
  end

  def page_title(text, header_size = 3)
    content_for :page_title do
      dynamic_page_title(text, header_size)
    end
  end

  def dynamic_page_title(text, header_size = 3)
    content_tag(:"h#{header_size}", text.html_safe, :class => "title")
  end

  def day_label(index)
    return '' unless SiteSettings.course_dates.respond_to?("year_#{session[:year]}")

    _sessions_to_sentence(SiteSettings.course_dates.send("year_#{session[:year]}"), index)
  end

  def pretty_course_dates(year)
    return '' unless SiteSettings.course_dates.respond_to?("year_#{Time.now.utc.year}")

    course_dates = SiteSettings.course_dates["year_#{Time.now.utc.year}"]
    all_sessions = (1..3).map { |index| _sessions_to_sentence(course_dates, index, index == 3) }

    all_sessions.to_sentence(:two_words_connector => ' & ')
  end

  private

  def _sessions_to_sentence(days, index, with_year = true)
    case days
    when Hash
      sessions = days["day_#{index}"]
      if sessions.one?
        dates = l(sessions.last, :format => :lite)
      else
        dates = sessions[0...-1].map { |d| l(d, :format => :month_day) }
        dates << l(sessions.last, :format => (with_year ? :day_year : :day))
      end
      Array(dates).to_sentence(:two_words_connector => ' & ', :last_word_connector => ', & ')

    when Array
      l(days[index-1], :format => :lite)
    end
  end

end
