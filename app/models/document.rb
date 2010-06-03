class Document
  include MongoMapper::Document
  
  key :title,        String,   :required => true
  key :module_id,    String,   :default => nil
  key :file,         String,   :required => true
  key :file_cache,   String
  key :published_at, DateTime, :default => nil
  timestamps!
  
  mount_uploader :file, DocumentUploader
end