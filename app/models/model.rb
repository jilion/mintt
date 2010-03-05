class Model
  
  cattr_reader :per_page
  @@per_page = 15
  
  def self.order_by(options = {})
    paginate(:order => "#{options[:order_by] || 'id'} #{options[:sort_way] || 'asc'}", :per_page => (options[:per_page] || @@per_page), :page => options[:page])
  end
  
end