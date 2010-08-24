class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  
  @@per_page = 10
  
  field :sender_name,  :type => String
  field :sender_email, :type => String
  field :content,      :type => String
  field :read_at,      :type => Time, :default => nil
  field :replied_at,   :type => Time, :default => nil
  field :trashed_at,   :type => Time, :default => nil
  # timestamps!
  
  # Email regex used to validate email formats. Retrieved from authlogic.
  # EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  
  validates_presence_of :sender_name, :message => "This field can't be empty"
  validates_presence_of :sender_email, :message => "This field can't be empty"
  validates_presence_of :content, :message => "This field can't be empty"
  
  validates_format_of :sender_email, :with => Devise.email_regexp
  
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
  
  def sender_name
    read_attribute(:sender_name).titleize
  end
  
protected
  
  # after_create
  def notify_of_new_message
    MinttMailer.new_message(self).deliver
  end
  
  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'created_at'} #{options[:sort_way] || 'desc'}" }
  end
  
  def self.should_paginate(params = {})
    !params.key? :all
  end
  
end