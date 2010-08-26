class Teacher
  include Mongoid::Document
  include Mongoid::Timestamps
  include FinderExtension
  
  cattr_accessor :per_page
  @@per_page = 10
  
  field :name,      :type => String
  field :email,     :type => String
  field :module_id, :type => Integer, :default => nil
  
  devise :database_authenticatable, :validatable, :registerable, :rememberable, :recoverable, :invitable
  
  liquid_methods *Teacher.fields.keys
  
  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params = {})
    method, options = method_and_options(params)
    order_by((params[:order_by] || :confirmed_at).to_sym.send(params[:sort_way] || :desc)).send(method, options)
  end
  
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