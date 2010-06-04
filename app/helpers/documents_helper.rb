module DocumentsHelper
  
  def pretty_file(document)
    return if document.new_record?
    html = "#{document.extension.upcase}: #{document.title}"
    html << " (#{document.filename})" unless document.filename == document.title
    html
  end
  
  def pretty_class(document)
    if document.image?
      'image'
    else
      document.extension
    end
  end
  
  def published_icon(document)
    (document.published_at && document.published_at <= Time.now) ? image_tag("/images/admin/selected.png", :alt => "selected") : ""
  end
  
  def list_documents_for_module(module_id)
    @documents.select { |doc| doc.module_id == module_id }.inject("") do |html, doc|
      html << content_tag(:li, link_to(pretty_file(doc), doc.url), :class => pretty_class(doc))
      html << content_tag(:div, doc.description, :class => 'description') if doc.description.present?
      html
    end.html_safe
  end
  
end