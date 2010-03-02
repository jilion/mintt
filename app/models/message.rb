class Message
  include MongoMapper::Document

  key :sender_name, String
  key :sender_email, String
  key :content, String
  key :read, Boolean
  key :replied, Boolean

  timestamps!

  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i

  validates_presence_of :sender_name, :sender_email, :content, :message => "This field can't be empty"

  validates_format_of :sender_email, :with => EMAIL_REGEX

  def before_create
    self.read, self.replied = false, false
  end

end
