class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension
  
  cattr_accessor :per_page
  @@per_page = 10
  
  field :sender_name,  :type => String
  field :sender_email, :type => String
  field :content,      :type => String
  field :read_at,      :type => Time, :default => nil
  field :replied_at,   :type => Time, :default => nil
  field :trashed_at,   :type => Time, :default => nil
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :sender_name, :message => "This field can't be empty"
  validates_presence_of :sender_email, :message => "This field can't be empty"
  validates_presence_of :content, :message => "This field can't be empty"
  validates_format_of :sender_email, :with => Devise.email_regexp
  
  # =============
  # = Callbacks =
  # =============
  after_create :notify_of_new_message
  
  # ==========
  # = Scopes =
  # ==========
  scope :trashed, lambda { |trashed| trashed ? where(:trashed_at.ne => nil) : where(:trashed_at => nil) }
  
  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params = {})
    method, options = method_and_options(params)
    trashed(params[:trashed]).order_by((params[:order_by] || :confirmed_at).to_sym.send(params[:sort_way] || :desc)).send(method, options)
  end
  
  # ====================
  # = Instance Methods =
  # ====================
  def unread?
    read_at.nil?
  end
  
  def read?
    !unread?
  end
  
  def unreplied?
    replied_at.nil?
  end
  
  def replied?
    !unreplied?
  end
  
  def trashed?
    trashed_at.present?
  end
  
  def sender_name
    read_attribute(:sender_name).present? ? read_attribute(:sender_name).titleize : ""
  end
  
protected
  
  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'created_at'} #{options[:sort_way] || 'desc'}" }
  end
  
  # after_create
  def notify_of_new_message
    MinttMailer.new_message(self).deliver
  end
  
end