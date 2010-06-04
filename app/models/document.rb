class Document
  include MongoMapper::Document
  
  attr_accessor :file
  
  key :title,        String
  key :description,  String
  key :module_id,    String,   :default => nil
  key :filename,     String,   :required => true
  key :published_at, DateTime, :default => nil
  timestamps!
  
  validate :presence_of_file
  
  after_destroy :delete_file
  
  def file=(new_file)
    ext = File.extname(new_file.original_filename)
    @filename = new_file.original_filename[0..new_file.original_filename.size-ext.size].parameterize + ext
    File.open(path, "wb") { |f| f.write(new_file.read) }
  end
  
  def file
    File.open(@filename, "r")
  end
  
  def url
    "/#{Document.upload_folder.join('/')}/#{@filename}" if @filename
  end
  
  def image?
    (extension =~ /(jpe?|pn)g|gif/).present?
  end
  
  def extension
    File.extname(@filename).sub('.', '') if @filename
  end
  
  def title
    @title.present? ? @title : @filename
  end
  
  def method_missing(method, *args, &block)
    if /^(.+)\?$/.match(method.to_s).present?
      extension == $1
    end
  end
  
protected
  
  def path
    Pathname.new(Document.upload_path).join(@filename)
  end
  
  def self.upload_path
    p = Rails.root.join('public', *self.upload_folder)
    FileUtils.mkdir_p p unless p.directory?
    p
  end
  
  def self.upload_folder
    %w[uploads documents]
  end
  
  # validate
  def presence_of_file
    errors.add(:file, "File must be present!") if @filename.blank?
  end
  
  def delete_file
    File.delete(path) if File.file? path
  end
  
end