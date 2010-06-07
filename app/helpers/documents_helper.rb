module DocumentsHelper
  
  def pretty_file(document)
    return if document.new_record?
    html = "#{document.extension.upcase}: "
    linked = "#{document.title}"
    linked << " (#{document.filename})" unless document.filename == document.title
    "#{html}#{link_to(linked, document.url)}".html_safe
  end
  
  def pretty_class(document)
    if document.image?
      'image'
    else
      document.extension
    end
  end
  
  def published_icon_or_date(document)
    document.published_at <= Time.now ? image_tag("/images/admin/selected.png", :alt => "selected") : document.published_at.to_date.to_s(:lite)
  end
  
  def list_documents_for_module(module_id)
    @documents.select { |doc| doc.module_id == module_id }.inject("") do |html, doc|
      # html << "<li class='#{pretty_class(doc)}'>#{pretty_file(doc)}
      # #{content_tag(:div, doc.description, :class => 'description') if doc.description.present?}"
      html << "<li class='#{pretty_class(doc)}' title='#{doc.description if doc.description.present?}'>#{pretty_file(doc)}"
    end.html_safe
  end
  
end