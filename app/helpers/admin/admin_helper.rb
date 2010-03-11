module Admin::AdminHelper
  
  def sort_parameters(field)
    { :all => params[:all], :order_by => field, :sort_way => invert_sort_way(field) }
  end
  
  def invert_sort_way(field)
    (params[:sort_way]||'').downcase == 'asc' && params[:order_by] == field ? 'desc' : 'asc'
  end
  
  def smart_objects_objects_displayed_range(collection)
    return 0 if collection.blank?
    begin
      from = collection.per_page*(collection.current_page-1)+1
      to = [collection.total_entries, collection.per_page*collection.current_page].min
      "#{from}-#{to}"
    rescue
      collection.size
    end
  end
  
  def smart_objects_count(collection)
    return 0 if collection.blank?
    begin
      collection.total_entries
    rescue
      collection.size
    end
  end
  
end