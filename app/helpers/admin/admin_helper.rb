module Admin::AdminHelper
  
  def sort_parameters(field)
    { :all => params[:all], :order_by => field, :sort_way => invert_sort_way(field) }
  end
  
  def invert_sort_way(field)
    (params[:sort_way]||'').downcase == 'asc' && params[:order_by] == field ? 'desc' : 'asc'
  end
  
  def smart_objects_objects_displayed_range(collection)
    return 0 if collection.blank?
    
    if collection.respond_to?(:total_entries) && collection.respond_to?(:per_page) && collection.respond_to?(:current_page)
      from = collection.per_page*(collection.current_page-1)+1
      to = [collection.total_entries, collection.per_page*collection.current_page].min
      "#{from}-#{to}"
    else
      collection.size
    end
  end
  
  def smart_objects_count(collection)
    return 0 if collection.blank?
    
    collection.respond_to?(:total_entries) ? collection.total_entries : collection.size
  end
  
  def count_of_total_for(collection)
    return "" if collection.blank?
    
    "#{smart_objects_objects_displayed_range(collection)} of #{smart_objects_count(collection)}"
  end
  
  def update_field_form(record, field, value, submit_text = "update", form_options = {}, submit_options = {})
    form_for([:admin, record], form_options) do |f|
      f.hidden_field(field.to_sym, :value => value) + f.submit(submit_text, submit_options)
    end
  end
  
end