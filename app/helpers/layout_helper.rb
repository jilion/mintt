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
      content_tag(:"h#{header_size}", text.html_safe, :class => "title")
    end
  end
  
  def dynamic_page_title(text, header_size = 3)
    content_tag(:"h#{header_size}", text.html_safe, :class => "title")
  end
  
end