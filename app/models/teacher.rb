class Teacher
  include Mongoid::Document
  include Mongoid::Timestamps
  
  cattr_accessor :per_page
  @@per_page = 10
  
  field :name,      :type => String
  field :email,     :type => String
  field :module_id, :type => Integer, :default => nil
  
  devise :database_authenticatable, :validatable, :registerable, :rememberable, :recoverable, :invitable
  
  liquid_methods *Teacher.fields.keys
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :email, :message => "This field can't be empty"
  validates_uniqueness_of :email
  
  # =================
  # = Class Methods =
  # =================
  def self.index_order_by(params = {})
    options = { :page => params[:page], :per_page => @@per_page } if should_paginate(params)
    
    order_by((params[:order_by] || :confirmed_at).to_sym.send(params[:sort_way] || :desc)).
    send((should_paginate(params) ? :paginate : :all), options || {})
  end
  
  def self.should_paginate(params = {})
    !params.key? :all
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