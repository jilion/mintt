module Admin::DocumentsHelper
  
  def admin_pretty_file(document, *args)
    return if document.new_record? || document.extension.blank?
    
    if document.image?
      link_to(image_tag(document.url, :width => 800), document.url)
    else
      pretty_file(document, args)
    end
  end
  
end
