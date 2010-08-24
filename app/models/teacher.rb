class Teacher
  include Mongoid::Document
  include Mongoid::Timestamps
  
  cattr_accessor :per_page
  @@per_page = 10
  
  field :name,      :type => String
  field :email,     :type => String, :required => true, :unique => true
  field :module_id, :type => Integer, :default => nil
  
  devise :database_authenticatable, :validatable, :registerable, :rememberable, :recoverable, :invitable
  
  liquid_methods *Teacher.fields.keys
  
  # ===============
  # = Validations =
  # ===============
  
  # validates_format_of :email, :with => Devise.email_regexp
  
  # ====================
  # = Instance Methods =
  # ====================
  
  def has_accepted_invitation?
    invitation_sent_at.present? && invitation_token.nil?
  end
  
  def name_or_email
    name.blank? ? email : name
  end
  
end

class Teacher::LiquidDropClass
  
  include Mintt::Application.routes.url_helpers
  
  def invitation_link
    accept_teacher_invitation_url(:host => ActionMailer::Base.default_url_options[:host], :invitation_token => self.invitation_token)
  end
  
end