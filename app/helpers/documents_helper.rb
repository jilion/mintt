module DocumentsHelper
  
  def pretty_file(document, *args)
    return if document.new_record?
    options = args.extract_options!
    options.reverse_merge!(:type => true)
    
    "#{"#{document.extension.upcase}: " if options[:type]}#{link_to(document.title, document.url)}".html_safe
  end
  
  def published_class(document)
    document.published? ? ' published' : ' futur'
  end
  
  def published_infos(document)
    if document.published?
      "#{time_ago_in_words(document.published_at)} ago"
    else
      document.published_at.strftime("%B %d, %Y %H:%M")
    end.html_safe
  end
  
  def list_documents_for_module(module_id)
    @documents.select { |doc| doc.module_id == module_id }.inject("") do |html, doc|
      # html << "<li class='#{pretty_class(doc)}'>#{pretty_file(doc)}
      # #{content_tag(:div, doc.description, :class => 'description') if doc.description.present?}"
      html << content_tag(:li, pretty_file(doc), :title => doc.description)
    end
  end
  
end