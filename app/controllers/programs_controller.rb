class ProgramsController < ApplicationController
  respond_to :html
  respond_to :js, :only => :index

  before_filter :authenticate_user!, :unless => proc { |controller| controller.teacher_signed_in? }
  before_filter :authenticate_teacher!, :unless => proc { |controller| controller.user_signed_in? }
  before_filter :set_year, :only => :index

  # /schedule
  def index
    @modules   = TeachingModule.year(session[:year]).order_by(:module_id.asc)
    @documents = Document.year(session[:year]).published.order_by(:module_id.asc, :published_at.asc)
  end

  private

    def set_year
      if user_signed_in?
        session[:year] = valid_year(current_user.year)
      else # teacher signed in
        if params[:year] && current_teacher.years.include?(params[:year].to_i)
          session[:year] = valid_year(params[:year].to_i)
        else
          session[:year] ||= valid_year(current_teacher.years.try(:max))
        end
      end
    end

    def valid_year(year)
      if SiteSettings.course_dates.respond_to?("year_#{year}")
        year
      elsif year > 2010
        valid_year(year - 1)
      else
        2010
      end
    end

end
