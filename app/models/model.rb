class Model
  
  cattr_reader :instances_in_table
  @@instances_in_table      = 10
  
  def self.order_by(options={})
    paginate(:order => "#{options[:order_by]||'id'} #{options[:sort_way]||'asc'}", :per_page => (options[:per_page] || @@instances_in_table), :page => (options[:page] || 1))
  end
  
end