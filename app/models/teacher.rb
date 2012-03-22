class Teacher
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension

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

  ## Invitable
  field :invitation_token,       :type => String
  field :invitation_sent_at,     :type => Time
  field :invitation_accepted_at, :type => Time
  field :invitation_limit,       :type => Integer
  field :invited_by_id,          :type => Integer
  field :invited_by_type,        :type => String

  field :name,      :type => String
  field :module_id, :type => Integer, :default => nil
  field :years,     :type => Array

  index :email, :unique => true
  index :years

  devise :database_authenticatable, :validatable, :registerable, :rememberable, :recoverable, :invitable, :encryptable, :encryptor => :sha1

  cattr_accessor :per_page
  @@per_page = 15

  attr_accessor :current_password

  attr_accessible :password, :current_password, :name, :email, :invitation_sent_at, :module_id, :years

  # ===============
  # = Validations =
  # ===============
  validates :email, :presence => true

  liquid_methods *Teacher.fields.keys

  # ==========
  # = Scopes =
  # ==========
  scope :year,     lambda { |years| any_in(:years => years) }
  scope :not_year, lambda { |years| not_in(:years => years) }

  # =================
  # = Class Methods =
  # =================

  def self.index_order_by(params={})
    scopes = if params[:not_year]
      not_year([params[:not_year].to_i])
    else
      year = params[:year] || Time.now.utc.year
      year([year.to_i])
    end
    scopes.order_by((params[:order_by] || :confirmed_at).to_sym.send(params[:sort_way] || :desc)).all
  end

  # ====================
  # = Instance Methods =
  # ====================

  def invitation_accepted?
    invitation_sent_at.present? && invitation_token.nil?
  end

  def name_or_email
    name.blank? ? email : name
  end

  def years=(years)
    write_attribute(:years, years.compact.reject(&:blank?).map(&:to_i))
  end

  def years_for_select
    ([years.try(:min) || 2010, 2010].min..Time.now.utc.year).to_a
  end

end

class Teacher::LiquidDropClass

  include Mintt::Application.routes.url_helpers

  def invitation_link
    accept_teacher_invitation_url(:host => ActionMailer::Base.default_url_options[:host], :invitation_token => self.invitation_token)
  end

end
