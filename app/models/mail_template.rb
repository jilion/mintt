class MailTemplate
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning

  field :title,   :type => String
  field :content, :type => String

  attr_accessible :title, :content

  # ===============
  # = Validations =
  # ===============
  validates :title, :content, :presence => true
  validates :title, :uniqueness => true

end
