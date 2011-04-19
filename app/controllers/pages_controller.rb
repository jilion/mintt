class PagesController < ApplicationController
  respond_to :html

  def show
    render params[:id]
  end

end
