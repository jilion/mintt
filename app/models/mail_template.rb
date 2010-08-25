class MailTemplate
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title,   :type => String
  field :content, :type => String
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :title, :content, :message => "This field can't be empty"
  validates_uniqueness_of :title
end