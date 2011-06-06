class DocumentsController < ApplicationController
  before_filter :require_authentication!

  # GET /admin/documents/:id
  def show
    @document = Document.find(params[:id])

    if (teacher_signed_in? && current_teacher.years.include?(@document.published_at.year)) ||
      (user_signed_in? && current_user.year == @document.published_at.year) || admin?
      send_file(@document.path, :filename => @document.filename, :type => @document.mime_type || MIME::Types.of(@document.filename))
    else
      redirect_to root_url, :alert => "You are not authorized to see this file!"
    end
  end

  private

  def require_authentication!
    unless teacher_signed_in? || user_signed_in? || admin?
      redirect_to root_url, :alert => "You are not authorized to see this file!"
    end
  end

end
