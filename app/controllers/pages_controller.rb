class PagesController < ApplicationController
 
 # caches_page :show
 
  def show
    render params[:id]
  end
  
end