class MailTemplate
  include MongoMapper::Document
  
  key :title, String
  key :content, String
  timestamps!
  
  validates_presence_of :title, :content, :message => "This field can't be empty"
  
  validates_uniqueness_of :title
  
end