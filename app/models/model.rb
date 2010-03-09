class Model
  
  cattr_reader :per_page
  @@per_page = 15
  
  def self.all_order_by(sort_options = {}, options = {})
    all(options.merge(:order => "#{sort_options[:order_by] || 'created_at'} #{sort_options[:sort_way] || 'desc'}"))
  end
  
  def self.paginate_all_order_by(sort_options = {}, options = {})
    all_order_by(sort_options, options).paginate(:per_page => (options[:per_page] || @@per_page), :page => options[:page])
  end
  
end