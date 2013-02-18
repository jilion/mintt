module LayoutHelper

  def title_and_page_title(text, header_size=3)
    title(text)
    page_title(text, header_size)
  end

  def title(text)
    content_for :title do
      " | #{strip_tags(text)}"
    end
  end

  def page_title(text, header_size=3)
    content_for :page_title do
      dynamic_page_title(text, header_size)
    end
  end

  def dynamic_page_title(text, header_size=3)
    content_tag(:"h#{header_size}", text.html_safe, :class => "title")
  end

  def pretty_course_dates(year)
    return '' unless SiteSettings.course_dates.respond_to?("year_#{Time.now.utc.year}")

    course_dates = SiteSettings.course_dates["year_#{Time.now.utc.year}"]
    first_session  = course_dates.first
    second_session = course_dates.second
    last_session   = course_dates.last

    "#{first_session.strftime("%B")} #{first_session.strftime("%-d")} & #{second_session.strftime("%-d")} and #{last_session.strftime("%B")} #{last_session.strftime("%-d")}, #{year}"
  end

end
