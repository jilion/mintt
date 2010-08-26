module PagesHelper
  
  def module_box(&block)
    content_tag(:li) do
      content_tag(:div, "", :class => 'top') +
      content_tag(:div, :class => 'wrap') do
        content_tag(:div, :class => 'back') do
          haml_concat capture_haml(&block)
        end +
        content_tag(:div, "", :class => 'spacer')
      end +
      content_tag(:div, "", :class => 'bottom')
    end
  end
  
end