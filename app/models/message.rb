class Message
  include MongoMapper::Document
  
  @@per_page = 10
  
  key :sender_name,  String
  key :sender_email, String
  key :content,      String
  key :read_at,      Time, :default => nil
  key :replied_at,   Time, :default => nil
  key :trashed_at,   Time, :default => nil
  timestamps!
  
  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  
  validates_presence_of :sender_name, :sender_email, :content, :message => "This field can't be empty"
  
  validates_format_of :sender_email, :with => EMAIL_REGEX
  
  after_create :notify_of_new_message
  
  # =================
  # = Class Methods =
  # =================
  
  def self.index_order_by(params = {})
    options = order_hash(params).merge(:trashed_at => nil)
    options.merge!({ :page => params[:page], :per_page => @@per_page }) if should_paginate(params)
    send((should_paginate(params) ? "paginate" : "all"), options)
  end
  
  def self.trash_order_by(params = {})
    options = order_hash(params).merge(:trashed_at.ne => nil)
    options.merge!({ :page => params[:page], :per_page => @@per_page }) if should_paginate(params)
    send((should_paginate(params) ? "paginate" : "all"), options)
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
  
protected
  
  # after_create
  def notify_of_new_message
    MinttMailer.deliver_new_message(self)
  end
  
  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'created_at'} #{options[:sort_way] || 'desc'}" }
  end
  
  def self.should_paginate(params = {})
    !params.key? :all
  end
  
end