class PagesController < ActionController::Base
  
  def show
    render params[:id]
  end
  
end
