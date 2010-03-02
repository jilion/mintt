class User
  include MongoMapper::Document
  
  key :gender, Boolean, :required => true
  key :first_name, String, :required => true
  key :last_name, String, :required => true
  key :faculty, String, :required => true
  key :email, String, :required => true
  key :phone, String, :required => true
  key :url, String
  key :linkedin_url, String
  key :thesis_supervisor, String, :required => true
  key :thesis_subject, String, :required => true
  key :supervisor_authorization, Boolean, :require => true
  key :doctoral_school_rules, Boolean, :require => true
  key :thesis_invention, String
  key :motivation, String
  key :agreement, Boolean, :require => true
  timestamps!
  
  devise :registerable, :confirmable #, :authenticatable, :activatable, :recoverable, :rememberable, :trackable, :timeoutable, :lockable
  
  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i
  LINKEDIN_URL_REGEX = /\A(http|https):\/\/([a-z]+)\.linkedin\.com\/in\/([a-z0-9]+)\z/i
  
  # validates_presence_of :first_name
  # validates_presence_of :last_name
  # validates_presence_of :faculty
  # validates_presence_of :phone
  # validates_presence_of :thesis_supervisor
  # validates_presence_of :thesis_subject
  # validates_presence_of :supervisor_authorization
  # validates_presence_of :doctoral_school_rules
  # validates_presence_of :agreement
  
  validates_uniqueness_of :email, :allow_blank => false
  
  validates_format_of :email, :with => EMAIL_REGEX, :allow_blank => false
  validates_format_of :url, :with => URL_REGEX, :allow_blank => true
  validates_format_of :linkedin_url, :with => LINKEDIN_URL_REGEX, :allow_blank => true
  
  # validates_presence_of :password, :if => :password_required?
  # validates_confirmation_of :password, :if => :password_required?
  # validates_length_of :password, :within => 6..20, :allow_blank => true, :if => :password_required?
  
protected
  
  def password_required?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
  
end
