class User
  include MongoMapper::Document
  # For dates (because dates are splitted in multiple parameters in forms, it recreate the real attribute from these multiple parts)
  include MultiParameterAttributes
  
  @@per_page = 10
  
  attr_accessor :agreement, :is_selected
  
  key :gender,                   String, :required => true
  key :first_name,               String, :required => true
  key :last_name,                String, :required => true
  key :school,                   String, :required => true
  key :lab,                      String, :required => true
  key :email,                    String, :required => true, :unique => true
  key :phone,                    String, :required => true
  key :url,                      String
  key :linkedin_url,             String
  key :thesis_supervisor,        String, :required => true
  key :thesis_subject,           String, :required => true
  key :thesis_registration_date, Date
  key :thesis_admission_date,    Date
  key :supervisor_authorization, String
  key :doctoral_school_rules,    String
  key :thesis_invention,         String
  key :motivation,               String, :required => true
  key :comment,                  String
  key :year,                     Integer, :default => Time.now.year
  key :state,                    String
  key :selected_at,              Time
  key :trashed_at,               Time, :default => nil
  timestamps!
  
  devise :database_authenticatable, :registerable, :confirmable, :rememberable, :recoverable
  
  liquid_methods *User.keys.keys
  
  comma do
    gender
    first_name
    last_name
    school
    lab
    email
    phone
    url
    linkedin_url
    thesis_supervisor
    thesis_subject
    thesis_registration_date
    thesis_admission_date
    supervisor_authorization
    doctoral_school_rules
    thesis_invention
    motivation
    comment
  end
  
  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i
  LINKEDIN_URL_REGEX = /\A(http|https):\/\/([a-z]+)\.linkedin\.com\/in\/([a-z0-9]+)\z/i
  
  # ===============
  # = Validations =
  # ===============
  validates_format_of :email, :with => Devise::EMAIL_REGEX
  validates_format_of :url, :with => URL_REGEX, :allow_blank => true, :message => "Should start with http:// or https://"
  validates_format_of :linkedin_url, :with => LINKEDIN_URL_REGEX, :allow_blank => true, :message => "Should be similar to http://ch.linkedin.com/in/your_name"
  
  validates_inclusion_of :gender,                    :within => %w(male female), :message => "Choose a gender"
  validates_inclusion_of :supervisor_authorization,  :within => %w(yes no), :message => "Choose an answer"
  validates_inclusion_of :doctoral_school_rules,     :within => %w(yes no), :message => "Choose an answer"
  
  validate :validate_registration_and_admission_date
  validate :validate_registration_before_admission_date
  validates_acceptance_of :agreement, :message => "You must accept the agreement.", :if => proc { |u| u.new_record? }
  
  # =============
  # = Callbacks =
  # =============
  
  after_update :fire_state_change
  
  # =================
  # = State Machine =
  # =================
  
  state_machine :initial => :candidate do
    event(:select) { transition :candidate => :selected }
    after_transition :on => :select, :do => :select!
    
    event(:cancel) { transition :selected => :candidate }
    after_transition :on => :cancel, :do => :cancel!
  end
  
  # =================
  # = Class Methods =
  # =================
  
  def self.index_order_by(params = {})
    options = order_hash(params).merge(:confirmed_at.ne => nil, :trashed_at => nil)
    options.merge!({ :page => params[:page], :per_page => @@per_page }) if should_paginate(params)
    send((should_paginate(params) ? "paginate" : "all"), options)
  end
  
  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'confirmed_at'} #{options[:sort_way] || 'desc'}" }
  end
  
  def self.should_paginate(params = {})
    !params.key? :all
  end
  
  # ====================
  # = Instance Methods =
  # ====================
  
  def fire_state_change
    case is_selected
    when '1' # congrats, you're now selected, send mail to sign up
      self.select if candidate?
    when '0' # cancel selection
      self.cancel if selected?
    end
  end
  
  def has_been_selected?
    selected_at.present?
  end
  
  def has_created_account?
    has_been_selected? && self.reset_password_token.nil?
  end
  
  def trashed?
    trashed_at.present?
  end
  
protected
  
  def validate_registration_and_admission_date
    [:thesis_registration_date, :thesis_admission_date].each do |date|
      if send(date) == Date.new
        self.send("#{date}=", nil)
        errors.add(date, "please enter a valid date")
      end
    end
  end
  
  def validate_registration_before_admission_date
    if self.thesis_registration_date.present? && self.thesis_admission_date.present? && self.thesis_registration_date > self.thesis_admission_date
      errors.add(:thesis_registration_date, "must be before the admission date")
    end
  end
  
  def select!
    self.update_attributes!({ :selected_at => Time.now })
    self.generate_reset_password_token!
    ::MinttMailer.deliver_sign_up_instructions(self)
  end
  
  def cancel!
    self.update_attributes!({ :selected_at => nil, :reset_password_token => nil })
  end
  
end


class User::LiquidDropClass
  
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlWriter
  include Admin::UsersHelper
  
  def full_name
    full_name(self)
  end
  
  def confirmation_link
    url_for(ApplicationController.new.default_url_options.merge({ :only_path => false, :controller => 'confirmations', :action => 'show', :confirmation_token => self.confirmation_token }))
  end
  
  def set_password_link
    url_for(ApplicationController.new.default_url_options.merge({ :only_path => false, :controller => 'passwords', :action => 'edit', :reset_password_token => self.reset_password_token }))
  end
  
end