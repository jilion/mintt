class Document
  include MongoMapper::Document
  
  attr_accessor :file
  
  key :title,        String
  key :module_id,    String,   :default => nil
  key :filename,     String,   :required => true
  key :published_at, DateTime, :default => nil
  timestamps!
  
  def file=(new_file)
    @filename = new_file.original_filename
    File.open(Rails.root.join('public', 'uploads', 'documents', @filename), "wb") { |f| f.write(new_file.read) }
  end
  
  def file
    File.open(@filename, "r")
  end
  
  def filename
    "/uploads/documents/#{@filename}" if @filename
  end
  
  def image?
    (extension =~ /(jpe?|pn)g|gif/).present?
  end
  
  def extension
    File.extname(@filename).sub('.', '') if @filename
  end
  
  def method_missing(method, *args, &block)
    if /^(.+)\?$/.match(method.to_s).present?
      extension == $1
    end
  end
  
  def title
    @title.present? ? @title : @filename
  end
  
end