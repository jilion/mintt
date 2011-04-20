class Teacher
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension

  field :name,      :type => String
  field :email,     :type => String
  field :module_id, :type => Integer, :default => nil
  field :years,     :type => Array

  index :email, :unique => true
  index :years

  devise :database_authenticatable, :validatable, :registerable, :rememberable, :recoverable, :invitable, :encryptable, :encryptor => :sha1

  cattr_accessor :per_page
  @@per_page = 15

  attr_accessor :current_password

  attr_accessible :password, :current_password, :name, :email, :module_id, :years

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
