class Message
  include MongoMapper::Document
  
  @@per_page = 10
  
  key :sender_name, String
  key :sender_email, String
  key :content, String
  key :read_at, DateTime, :default => nil
  key :replied_at, DateTime, :default => nil
  key :trashed_at, DateTime, :default => nil
  timestamps!
  
  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  
  validates_presence_of :sender_name, :sender_email, :content, :message => "This field can't be empty"
  
  validates_format_of :sender_email, :with => EMAIL_REGEX
  
  after_create :notify_of_new_message
  
protected
  
  # after_create
  def notify_of_new_message
    MessageMailer.deliver_new_message(self)
  end
  
public
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
  
private
  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'created_at'} #{options[:sort_way] || 'desc'}" }
  end
  
  def self.should_paginate(params = {})
    !params.key?(:all)
  end
  
  # def self.all_order_by(sort_options = {}, options = {})
  #   super(sort_options, options.reverse_merge(:trashed_at => nil))
  # end
  # 
  # def self.paginate_order_by(sort_options = {}, options = {})
  #   super(sort_options, options.reverse_merge(:trashed_at => nil, :per_page => @@per_page))
  # end
  # 
  # def self.paginate_order_by(sort_options = {}, options = {})
  #   order = { :order => "#{sort_options[:order_by] || 'created_at'} #{sort_options[:sort_way] || 'desc'}" }
  #   paginate(options.merge(order))
  # end
  # 
  # def self.all_trashed_order_by(sort_options = {}, options = {})
  #   all_order_by(sort_options, options.reverse_merge(:trashed_at.ne => nil))
  # end
  # 
  # def self.paginate_trashed_order_by(sort_options = {}, options = {})
  #   paginate_order_by(sort_options, options.reverse_merge(:trashed_at.ne => nil, :per_page => @@per_page))
  # end

public
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
    !trashed_at.nil?
  end
  
end