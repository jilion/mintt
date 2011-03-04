class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension

  cattr_accessor :per_page
  @@per_page = 10

  attr_accessor :agreement

  # Application fields
  field :gender,                   :type => String
  field :first_name,               :type => String
  field :last_name,                :type => String
  field :school,                   :type => String
  field :lab,                      :type => String
  field :email,                    :type => String, :unique => true
  field :phone,                    :type => String
  field :url,                      :type => String
  field :linkedin_url,             :type => String
  field :thesis_supervisor,        :type => String
  field :thesis_subject,           :type => String
  field :thesis_registration_date, :type => Date
  field :thesis_admission_date,    :type => Date
  field :supervisor_authorization, :type => String
  field :doctoral_school_rules,    :type => String
  field :thesis_invention,         :type => String
  field :motivation,               :type => String

  # Internal / protected fields
  field :comment,                  :type => String
  field :year,                     :type => Integer, :default => Time.now.year
  field :state,                    :type => String
  field :selected_at,              :type => Time
  field :case_study_title,         :type => String
  field :case_study_teacher,       :type => String
  field :credits_granted,          :type => Integer, :default => nil
  field :trashed_at,               :type => Time, :default => nil

  devise :database_authenticatable, :validatable, :registerable, :confirmable, :rememberable, :recoverable

  liquid_methods *User.fields.keys

  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i
  LINKEDIN_URL_REGEX = /\A(http|https):\/\/([a-z]+)\.linkedin\.com\/in\/([a-z0-9]+)\z/i

  # ===============
  # = Validations =
  # ===============
  validates_presence_of :first_name, :last_name, :school, :lab, :phone,
  :thesis_supervisor, :thesis_subject, :motivation, :message => "This field can't be empty"
  validates_presence_of :email, :message => "This field in needed"

  validates_format_of :url, :with => URL_REGEX, :allow_blank => true, :message => "Should start with http:// or https://"
  validates_format_of :linkedin_url, :with => LINKEDIN_URL_REGEX, :allow_blank => true, :message => "Should be similar to http://ch.linkedin.com/in/your_name"

  validates_inclusion_of :gender,                    :in => %w(male female), :message => "Choose a gender"
  validates_inclusion_of :supervisor_authorization,  :in => %w(yes no), :message => "Choose an answer"
  validates_inclusion_of :doctoral_school_rules,     :in => %w(yes no), :message => "Choose an answer"

  validate :validate_registration_before_admission_date
  validates_acceptance_of :agreement, :message => "You must accept the agreement.", :if => proc { |u| u.new_record? }

  # =============
  # = Callbacks =
  # =============
  before_update :update_state

  # ==========
  # = Scopes =
  # ==========
  scope :default_scope, where(:confirmed_at.ne => nil, :trashed_at => nil)

  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params = {})
    method, options = method_and_options(params)
    default_scope.where(:year => params[:year]).order((params[:order_by] || :confirmed_at).to_sym.send(params[:sort_way] || :desc)).send(method, options)
  end

  # ====================
  # = Instance Methods =
  # ====================
  def password_required?
    password.present? || password_confirmation.present?
  end

  # Devise customization
  def send_reset_password_instructions
    selected? ? super : errors.add(:email, "You're not allowed to reset your password!")
  end

  def update_state
    return unless self.state_changed?

    if self.state_change == ['candidate', 'selected']
      self.selected_at = Time.now
      self.generate_reset_password_token
      ::MinttMailer.sign_up_instructions(self).deliver
    elsif self.state_change == ['selected', 'candidate']
      self.selected_at, self.reset_password_token = nil, nil
    end
  end

  def candidate?
    state == 'candidate'
  end

  def selected?
    state == 'selected'
  end

  def has_created_account?
    selected? && reset_password_token.nil? && encrypted_password.present?
  end

  def trashed?
    trashed_at.present?
  end

  def self.to_csv(records, options={})
    column_names = self.fields.map { |f| f[0] } - %w[encrypted_password password_salt reset_password_token confirmation_token remember_token confirmation_sent_at remember_created_at confirmed_at created_at updated_at trashed_at]
    FasterCSV.generate(options) do |line|
      line << column_names
      records.each do |record|
        line << column_names.map { |column| record.attributes[column].to_s.gsub(/(\r\n|\t)/, ',') }
      end
    end
  end

protected

  def validate_registration_before_admission_date
    if self.thesis_registration_date.present? && self.thesis_admission_date.present? && self.thesis_registration_date > self.thesis_admission_date
      errors.add(:thesis_registration_date, "must be before the admission date")
    end
  end

end

class User::LiquidDropClass

  include Mintt::Application.routes.url_helpers
  include Admin::UsersHelper

  def full_name
    full_name(self)
  end

  def confirmation_link
    user_confirmation_url(:host => ActionMailer::Base.default_url_options[:host], :confirmation_token => self.confirmation_token)
  end

  def invitation_link
    edit_user_password_url(:host => ActionMailer::Base.default_url_options[:host], :reset_password_token => self.reset_password_token)
  end

end