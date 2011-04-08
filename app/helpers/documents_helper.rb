module DocumentsHelper

  def pretty_file(document, *args)
    return if document.new_record? || document.extension.blank?
    options = args.extract_options!
    options.reverse_merge!(:type => true)
    
    "#{"#{document.extension.upcase}: " if options[:type]}#{link_to(document.title, document_path(document))}".html_safe
  end

  def published_class(document)
    document.published? ? ' published' : ' futur'
  end

  def published_infos(document)
    return if document.blank? || document.published_at.blank?
    l(document.published_at.in_time_zone, :format => :full)
  end

  def list_documents_for_module(module_id)
    return if @documents.empty?
    
    @documents.select { |doc| doc.module_id == module_id }.inject("") do |html, doc|
      html << content_tag(:li, pretty_file(doc), :title => doc.description)
    end.html_safe
  end

end