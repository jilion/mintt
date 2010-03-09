class Model
  
  cattr_reader :per_page
  @@per_page = 10
  
  # Return all the model instances sorted on the field +sort_options[:order_by]+ (default to 'created_at')
  # by +sort_options[:sort_way]+ (asc or desc, default to desc)
  def self.all_order_by(sort_options = {}, options = {})
    all(options.merge(:order => "#{sort_options[:order_by] || 'created_at'} #{sort_options[:sort_way] || 'desc'}"))
  end
  
  # Return the +options[:per_page]+ (default to @@per_page) first model instances
  # sorted on the field +sort_options[:order_by]+ (default to 'created_at')
  # by +sort_options[:sort_way]+ (asc or desc, default to desc)
  def self.paginate_order_by(sort_options = {}, options = {})
    Rails.logger.info options.inspect
    paginate(options.merge(:order => "#{sort_options[:order_by] || 'created_at'} #{sort_options[:sort_way] || 'desc'}"))
  end
  
end