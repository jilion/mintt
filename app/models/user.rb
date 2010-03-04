class User < Model
  include MongoMapper::Document
  include MultiParameterAttributes

  attr_accessor :agreement

  key :gender, String
  key :first_name, String
  key :last_name, String
  key :faculty, String
  key :email, String
  key :phone, String
  key :url, String
  key :linkedin_url, String
  key :thesis_supervisor, String
  key :thesis_subject, String
  key :thesis_registration_date, Date
  key :thesis_admission_date, Date
  key :supervisor_authorization, String
  key :doctoral_school_rules, String
  key :thesis_invention, String
  key :motivation, String

  timestamps!

  devise :registerable, :confirmable #, :authenticatable, :activatable, :recoverable, :rememberable, :trackable, :timeoutable, :lockable

  liquid_methods *User.keys.keys

  validate :validate_registration_before_admission_date, :validate_admission_after_registration_date

  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i
  LINKEDIN_URL_REGEX = /\A(http|https):\/\/([a-z]+)\.linkedin\.com\/in\/([a-z0-9]+)\z/i

  validates_presence_of :email, :first_name, :last_name, 
  :faculty, :phone, :thesis_supervisor, 
  :thesis_subject, 
  :message => "This field can't be empty"

  validates_uniqueness_of :email

  validates_format_of :email, :with => EMAIL_REGEX
  validates_format_of :url, :with => URL_REGEX, :allow_blank => true
  validates_format_of :linkedin_url, :with => LINKEDIN_URL_REGEX, :allow_blank => true

  validates_inclusion_of  :gender, :within => %w(male female), :message => "Choose a gender"
  validates_inclusion_of  :supervisor_authorization, :within => %w(yes no), :message => "Choose an answer"
  validates_inclusion_of  :doctoral_school_rules, :within => %w(yes no), :message => "Choose an answer"

  validates_acceptance_of :agreement

  protected
  def password_required?
    new_record? || !password.nil? || !password_confirmation.nil?
  end

  def validate_registration_before_admission_date
    errors.add(:thesis_registration_date, "must be before the admission date") if self.thesis_registration_date > self.thesis_admission_date
  end

  def validate_admission_after_registration_date
    errors.add(:thesis_admission_date, "must be after the registration date") if self.thesis_admission_date < self.thesis_registration_date
  end

end