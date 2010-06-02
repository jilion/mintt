class Teacher
  include MongoMapper::Document
  
  @@per_page = 10
  
  key :name,  String
  key :email, String, :required => true, :unique => true
  timestamps!
  
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :invitable
  
  liquid_methods *Teacher.keys.keys
  
  # ================
  # = Associations =
  # ================
  
  # ==========
  # = Scopes =
  # ==========
  
  # ===============
  # = Validations =
  # ===============
  
  # ===============
  # = Validations =
  # ===============
  
  validates_format_of :email, :with => Devise::EMAIL_REGEX
  
  # =============
  # = Callbacks =
  # =============
  
  # =================
  # = State Machine =
  # =================
  
  # =================
  # = Class Methods =
  # =================
  
  # ====================
  # = Instance Methods =
  # ====================
  
  def has_accepted_invitation?
    invitation_sent_at.present? && invitation_token.nil?
  end
  
end


class Teacher::LiquidDropClass
  
  include ActionView::Helpers::UrlHelper
  include ActionController::UrlWriter
  
  def invitation_link
    url_for(ApplicationController.new.default_url_options.merge({ :only_path => false, :controller => 'invitations', :action => 'edit', :invitation_token => self.invitation_token }))
  end
  
end