class DocumentsController < ApplicationController
  before_filter :require_authentication!

  # GET /admin/documents/:id
  def show
    @document = Document.find(params[:id])

    if admin? ||
      (teacher_signed_in? && current_teacher.years.include?(@document.published_at.year)) ||
      (user_signed_in? && current_user.year == @document.published_at.year)
      send_file(@document.path, :filename => @document.filename, :type => @document.mime_type || MIME::Types.of(@document.filename))
    else
      render :text => "You are not authorized to see this file!", :status => 403
    end
  end

  private

  def require_authentication!
    return if admin?

    if !teacher_signed_in?
      authenticate_user!
    elsif !user_signed_in?
      authenticate_teacher!
    end
  end

end
