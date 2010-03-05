module Admin::AdminHelper
  
  def sort_parameters(field)
    { :all_order_by => field, :sort_way => invert_sort_way(field), :page => params[:page] }
  end
  
  def invert_sort_way(field)
    (params[:sort_way]||'').downcase == 'asc' && params[:all_order_by] == field ? 'desc' : 'asc'
  end
  
end