module Admin::DocumentsHelper
  
  def pretty_file(document)
    if document.image?
      image_tag(document.filename)
    else
      document.filename
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