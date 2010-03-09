class Message < Model
  include MongoMapper::Document
  
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
  def self.all_order_by(sort_options = {}, options = {})
    super(sort_options, options.reverse_merge(:trashed_at => nil))
  end
  
  def self.paginate_order_by(sort_options = {}, options = {})
    super(sort_options, options.reverse_merge(:trashed_at => nil, :per_page => @@per_page))
  end
  
  def self.all_trashed_order_by(sort_options = {}, options = {})
    Model.all_order_by(sort_options, options.reverse_merge(:trashed_at.ne => nil))
  end
  
  def self.paginate_trashed_order_by(sort_options = {}, options = {})
    Model.paginate_order_by(sort_options, options.reverse_merge(:trashed_at.ne => nil, :per_page => @@per_page))
  end
  
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