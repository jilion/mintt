class Document
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  include FinderExtension

  field :title,        :type => String
  field :description,  :type => String
  field :module_id,    :type => Integer, :default => nil
  field :filename,     :type => String
  field :mime_type,    :type => String
  field :published_at, :type => Time,    :default => nil

  cattr_accessor :per_page
  @@per_page = 15

  attr_writer :file

  attr_accessible :title, :description, :module_id, :file, :published_at

  # ===============
  # = Validations =
  # ===============
  validates :title, :presence => true
  validates :filename, :uniqueness => true
  validate :presence_of_file

  # =============
  # = Callbacks =
  # =============
  after_destroy :delete_file

  # ==========
  # = Scopes =
  # ==========
  scope :year,      lambda { |year| where(:published_at.gte => Time.utc(year.to_i).beginning_of_year, :published_at.lte => Time.utc(year.to_i).end_of_year) }
  scope :published, where(:published_at.lt => Time.now.utc)

  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params={})
    method, options = method_and_options_for_paginate(params)
    scopes = year(params[:year].try(:to_i) || Time.now.utc.year)
    scopes.order_by([params[:order_by] || :published_at, params[:sort_way] || :desc]).send(method, options)
  end

  # ====================
  # = Instance Methods =
  # ====================
  def file=(new_file)
    ext = File.extname(new_file.original_filename).downcase
    self.filename  = new_file.original_filename[0..new_file.original_filename.size-ext.size].parameterize + ext
    self.mime_type = MIME::Types.of(new_file.original_filename).first
    File.open(path, "w+") { |f| f.write(new_file.read) }
  end

  def url
    "/#{upload_folder.join('/')}/#{filename}"
  end

  def extension
    File.extname(filename).sub('.', '') if filename?
  end

  def title
    read_attribute(:title).present? ? read_attribute(:title) : filename
  end

  def image?
    !(extension =~ /(jpe?|pn)g|gif/).nil?
  end

  def published?
    published_at? && published_at <= Time.now.utc
  end

  def method_missing(method, *args, &block)
    if /^(.+)\?$/.match(method.to_s).present?
      extension == $1
    end
  end

  def upload_folder
    if created_at && created_at < Time.utc(2011,4,7) # backward compatibility
      %W[uploads documents]
    else
      year  = created_at.try(:year) || Time.now.utc.year
      month = created_at.try(:month) || Time.now.utc.month
      day   = created_at.try(:day) || Time.now.utc.day

      %W[uploads documents #{year} #{month} #{day}]
    end
  end

  def path
    p = Rails.root.join('public', *upload_folder)
    FileUtils.mkdir_p(p) unless p.directory?
    Pathname.new(p).join(filename)
  end

protected

  # validate
  def presence_of_file
    errors.add(:file, :blank) if filename.blank?
  end

  # after_destroy
  def delete_file
    File.delete(path) if File.file?(path)
  end

end