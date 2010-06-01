class Teacher
  include MongoMapper::Document
  
  @@per_page = 10
  
  key :name,  String, :required => true
  key :email, String, :required => true, :unique => true
  timestamps!
  
  devise :database_authenticatable, :rememberable, :recoverable, :invitable
  
  # ================
  # = Associations =
  # ================
  
  # ==========
  # = Scopes =
  # ==========
  
  # ===============
  # = Validations =
  # ===============
  
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
  
end