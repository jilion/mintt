class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include MultiParameterAttributes
  
  attr_accessor :file
  
  field :title,        :type => String,  :required => true
  field :description,  :type => String
  field :module_id,    :type => Integer, :default => nil
  field :filename,     :type => String,  :required => true
  field :published_at, :type => Time,    :default => nil
  # timestamps!
  
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
  
  def published?
    published_at <= Time.now
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
    path = Rails.root.join('public', *self.upload_folder)
    FileUtils.mkdir_p(path) unless path.directory?
    path
  end
  
  def self.upload_folder
    %w[uploads documents]
  end
  
  # validate
  def presence_of_file
    errors.add(:file, "File must be present!") if @filename.blank?
  end
  
  def delete_file
    File.delete(path) if File.file?(path)
  end
  
end