class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  
  attr_writer :file
  
  field :title,        :type => String
  field :description,  :type => String
  field :module_id,    :type => Integer, :default => nil
  field :filename,     :type => String
  field :published_at, :type => Time,    :default => nil
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :title, :message => "This field can't be empty"
  validate :presence_of_file
  
  # =============
  # = Callbacks =
  # =============
  after_destroy :delete_file
  
  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params = {})
    order_by((params[:order_by] || :published_at).to_sym.send(params[:sort_way] || :desc))
  end
  
  # ====================
  # = Instance Methods =
  # ====================
  def file=(new_file)
    ext = File.extname(new_file.original_filename)
    self.filename = new_file.original_filename[0..new_file.original_filename.size-ext.size].parameterize + ext
    File.open(path, "w+") { |f| f.write(new_file.read) }
  end
  
  def url
    "/#{Document.upload_folder.join('/')}/#{read_attribute(:filename)}"
  end
  
  def extension
    File.extname(read_attribute(:filename)).sub('.', '') if read_attribute(:filename)
  end
  
  def title
    read_attribute(:title).present? ? read_attribute(:title) : read_attribute(:filename)
  end
  
  def image?
    (extension =~ /(jpe?|pn)g|gif/).present?
  end
  
  def published?
    published_at.present? && published_at <= Time.now
  end
  
  def method_missing(method, *args, &block)
    if /^(.+)\?$/.match(method.to_s).present?
      extension == $1
    end
  end
  
protected
  
  def self.upload_path
    p = Rails.root.join('public', *self.upload_folder)
    FileUtils.mkdir_p(p) unless p.directory?
    p
  end
  
  def self.upload_folder
    %w[uploads documents]
  end
  
  # validate
  def presence_of_file
    errors.add(:file, "File must be present!") if read_attribute(:filename).blank?
  end
  
  def path
    Pathname.new(Document.upload_path).join(read_attribute(:filename))
  end
  
  def delete_file
    File.delete(path) if File.file?(path)
  end
  
end