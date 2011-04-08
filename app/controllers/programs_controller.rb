class ProgramsController < ApplicationController
  before_filter :authenticate_user!, :unless => proc { |controller| controller.teacher_signed_in? }
  before_filter :authenticate_teacher!, :unless => proc { |controller| controller.user_signed_in? }
  before_filter :set_year, :only => :index

  # /schedule
  def index
    @documents = Document.in_year(session[:year]).published.order_by(:module_id.asc, :published_at.asc)
  end

  private

    def set_year
      if user_signed_in?
        session[:year] = current_user.year
      else # teacher signed in
        if params[:year] && current_teacher.years.include?(params[:year].to_i)
          session[:year] = params[:year]
        else
          session[:year] ||= current_teacher.years.max || 2010
        end
      end
    end

end
