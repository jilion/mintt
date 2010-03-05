class Message < Model
  include MongoMapper::Document
  
  key :sender_name, String
  key :sender_email, String
  key :content, String
  key :read, Boolean, :default => false
  key :replied, Boolean, :default => false
  key :trashed, Boolean, :default => false
  timestamps!
  
  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  
  validates_presence_of :sender_name, :sender_email, :content, :message => "This field can't be empty"
  
  validates_format_of :sender_email, :with => EMAIL_REGEX
  
  after_create :notify_of_new_message
  
  def unread?
    !read?
  end
  
  def unreplied?
    !replied?
  end
  
protected
  
  # after_create
  def notify_of_new_message
    MessageMailer.deliver_new_message(self)
  end
  
end
