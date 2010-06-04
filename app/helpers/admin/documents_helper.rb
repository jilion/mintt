module Admin::DocumentsHelper
  
  def pretty_file(document, options={})
    if document.image?
      image_tag(document.url, :width => options[:width] ? options[:width] : "" )
    else
      document.url
    end
  end
  
  def pretty_class(document)
    if document.image?
      'image'
    else
      document.extension
    end
  end
  
end