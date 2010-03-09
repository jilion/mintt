module Admin::AdminHelper
  
  def sort_parameters(field)
    { :all => params[:all], :order_by => field, :sort_way => invert_sort_way(field), :page => params[:page] }
  end
  
  def invert_sort_way(field)
    (params[:sort_way]||'').downcase == 'asc' && params[:order_by] == field ? 'desc' : 'asc'
  end
  
  def smart_objects_objects_displayed_range(collections)
    begin
      from = collections.per_page*(collections.current_page-1)+1
      to = [collections.total_entries, collections.per_page*collections.current_page].min
      "#{from}-#{to}"
    rescue
      collections.size
    end
  end
  
  def smart_objects_count(collections)
    begin
      collections.total_entries
    rescue
      collections.size
    end
  end
  
end