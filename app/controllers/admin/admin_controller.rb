class Admin::AdminController < ApplicationController
  before_filter :admin_required
  layout 'admin'

  private

    def set_year
      if params[:admin_year]
        session[:admin_year] = params[:admin_year]
      else
        session[:admin_year] ||= Time.now.utc.year.to_s
      end
    end

end
