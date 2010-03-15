class User
  include MongoMapper::Document
  include MultiParameterAttributes
  
  @@per_page = 10
  
  attr_accessor :agreement
  
  key :gender, String
  key :first_name, String
  key :last_name, String
  key :school, String
  key :lab, String
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
  key :comment, String
  key :trashed_at, DateTime, :default => nil
  timestamps!
  
  devise :registerable, :confirmable
  
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
  
  # Email regex used to validate email formats. Retrieved from authlogic.
  EMAIL_REGEX = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
  URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/i
  LINKEDIN_URL_REGEX = /\A(http|https):\/\/([a-z]+)\.linkedin\.com\/in\/([a-z0-9]+)\z/i
  
  validates_presence_of :email, :first_name, :last_name, :school, :lab, :phone, :thesis_supervisor, :thesis_subject, :motivation,
                        :message => "This field can't be empty"
  
  validates_uniqueness_of :email
  
  validates_format_of :email, :with => EMAIL_REGEX
  validates_format_of :url, :with => URL_REGEX, :allow_blank => true, :message => "Should start with http:// or https://"
  validates_format_of :linkedin_url, :with => LINKEDIN_URL_REGEX, :allow_blank => true, :message => "Should be similar to http://ch.linkedin.com/in/your_name"
  
  validates_inclusion_of  :gender,                    :within => %w(male female), :message => "Choose a gender"
  validates_inclusion_of  :supervisor_authorization,  :within => %w(yes no), :message => "Choose an answer"
  validates_inclusion_of  :doctoral_school_rules,     :within => %w(yes no), :message => "Choose an answer"
  
  validate :validate_registration_and_admission_date
  validate :validate_registration_before_admission_date
  validate :validates_acceptance_of_agreement
  
protected
  
  def validates_acceptance_of_agreement
    if self.agreement != "1" && self.new_record?
      errors.add(:agreement, "must be accepted")
    end
  end

  def validate_registration_and_admission_date
    [:thesis_registration_date, :thesis_admission_date].each do |date|
      if send(date) == Date.new
        self.send("#{date}=", nil)
        errors.add(date, "please enter a valid date")
      end
    end
  end

  def validate_registration_before_admission_date
    return if self.thesis_registration_date.blank? || self.thesis_admission_date.blank?
    if self.thesis_registration_date > self.thesis_admission_date
      errors.add(:thesis_registration_date, "must be before the admission date")
    end
  end

public
  
  def self.index_order_by(params = {})
    should_paginate = !params.key?(:all)
    options = order_hash(params).merge(:confirmed_at.ne => nil, :trashed_at => nil)
    options.merge!({ :page => params[:page], :per_page => @@per_page }) if should_paginate(params)
    send((should_paginate(params) ? "paginate" : "all"), options)
  end
  
private
  def self.order_hash(options = {})
    { :order => "#{options[:order_by] || 'confirmed_at'} #{options[:sort_way] || 'desc'}" }
  end
  
  def self.should_paginate(params = {})
    !params.key?(:all)
  end

public
  
  def trashed?
    !trashed_at.nil?
  end
  
end


class User::LiquidDropClass
  
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlWriter
  include Admin::UsersHelper
  
  def full_name
    user_full_name(self)
  end
  
  def confirmation_link
    url_for({ :host => Rails.env.production? ? MINTT_EPFL : MINTT_LOCAL, :only_path => false, :controller => 'confirmations', :action => 'show', :confirmation_token => self.confirmation_token })
  end
  
end