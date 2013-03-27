class User
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  include FinderExtension

  # Application fields
  field :gender,                   :type => String
  field :first_name,               :type => String
  field :last_name,                :type => String
  field :school_and_lab,           :type => String
  # deprecated
  field :school,                   :type => String
  field :lab,                      :type => String

  field :phone,                    :type => String
  field :url,                      :type => String
  field :linkedin_url,             :type => String
  field :thesis_supervisor,        :type => String
  field :thesis_subject,           :type => String
  field :thesis_invention,         :type => String
  field :thesis_registration_date, :type => Date
  field :thesis_admission_date,    :type => Date
  field :supervisor_authorization, :type => String
  field :doctoral_school_rules,    :type => String
  field :motivation,               :type => String

  # Internal / protected fields
  field :comment,                  :type => String
  field :year,                     :type => Integer, :default => Time.now.year
  field :state,                    :type => String,  :default => 'candidate'
  field :selected_at,              :type => Time
  field :case_study_title,         :type => String
  field :case_study_teacher,       :type => String
  field :credits_granted,          :type => Integer, :default => nil
  field :trashed_at,               :type => Time,    :default => nil

  ## Database authenticatable
  field :email,              :type => String, :null => false
  field :encrypted_password, :type => String, :null => false

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  field :password_salt, :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time

  index :email, :unique => true
  index :state
  index :year

  devise :database_authenticatable, :validatable, :registerable, :confirmable, :rememberable, :recoverable, :encryptable, :encryptor => :sha1

  cattr_accessor :per_page
  @@per_page = 15

  attr_accessor :current_password, :agreement

  attr_accessible :password, :current_password, :trashed_at
  attr_accessible :state, :year, :gender, :first_name, :last_name, :school_and_lab, :email, :phone, :url, :linkedin_url, :thesis_supervisor, :thesis_subject, :thesis_invention, :thesis_registration_date, :thesis_admission_date, :supervisor_authorization, :doctoral_school_rules, :motivation, :agreement

  liquid_methods *User.fields.keys

  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i
  LINKEDIN_URL_REGEX = /\A(http|https):\/\/([a-z]+)\.linkedin\.com\/in\/([a-z0-9]+)\z/i
  CSV_NO_EXPORT_FIELDS = %w[encrypted_password password_salt reset_password_token confirmation_token remember_token confirmation_sent_at remember_created_at confirmed_at created_at updated_at trashed_at]

  # ===============
  # = Validations =
  # ===============
  validates :first_name, :last_name, :school_and_lab, :email, :phone, :thesis_supervisor, :thesis_subject, :motivation, :presence => true

  validates :url,          :format => { :with => URL_REGEX, :allow_blank => true }
  validates :linkedin_url, :format => { :with => LINKEDIN_URL_REGEX, :allow_blank => true }

  validates :gender, :inclusion => { :in => %w[male female], :allow_blank => false }
  validates :supervisor_authorization, :doctoral_school_rules, :inclusion => { :in => %w[yes no], :allow_blank => false }

  validate :validate_registration_before_admission_date

  validates :agreement, :acceptance => { :accept => "1" }, :on => :create

  # =============
  # = Callbacks =
  # =============
  before_update :update_state

  # ==========
  # = Scopes =
  # ==========
  scope :active, where(:confirmed_at.ne => nil, :trashed_at => nil)
  scope :year, lambda { |year| where(:year => year) }

  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params={})
    method, options = method_and_options_for_paginate(params)
    scopes = year(params[:year].try(:to_i) || Time.now.utc.year)
    scopes = scopes.active.order([params[:order_by] || :created_at, params[:sort_way] || :desc])
    Rails.logger.info scopes.inspect
    scopes.send(method, options)
  end

  def self.to_csv(records, options={})
    column_names = self.fields.map { |f| f[0] } - User::CSV_NO_EXPORT_FIELDS
    FasterCSV.generate(options) do |lines|
      lines << column_names
      records.each do |record|
        lines << column_names.map { |column| record.attributes[column].to_s.gsub(/(\r\n|\t)/, ',') }
      end
    end
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

    if self.state == 'selected'
      self.selected_at = Time.now.utc
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

  def active_for_authentication?
    selected?
  end

  def account_created?
    selected? && reset_password_token.nil? && encrypted_password.present?
  end

  def trashed?
    trashed_at?
  end

  def full_name(options={})
    (options[:reverse] == true ? "#{last_name} #{first_name}" : "#{first_name} #{last_name}").titleize
  end

protected

  def validate_registration_before_admission_date
    if self.thesis_registration_date.present? && self.thesis_admission_date.present? && self.thesis_registration_date > self.thesis_admission_date
      errors.add(:thesis_registration_date, :after_admission_date)
    end
  end

end

class User::LiquidDropClass

  include Mintt::Application.routes.url_helpers
  include Admin::UsersHelper

  def full_name
    self.full_name
  end

  def confirmation_link
    user_confirmation_url(:host => ActionMailer::Base.default_url_options[:host], :confirmation_token => self.confirmation_token)
  end

  def invitation_link
    edit_user_password_url(:host => ActionMailer::Base.default_url_options[:host], :reset_password_token => self.reset_password_token)
  end

end