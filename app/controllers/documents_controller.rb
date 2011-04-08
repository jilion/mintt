class DocumentsController < ApplicationController
  before_filter :require_authentication!

  # GET /admin/documents/:id
  def show
    @document = Document.find(params[:id])
    send_file(@document.path, :filename => @document.filename, :type => @document.mime_type || MIME::Types.of(@document.filename))
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
