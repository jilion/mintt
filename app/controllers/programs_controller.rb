class ProgramsController < ApplicationController
  before_filter :authenticate_user!, :unless => proc { |controller| controller.teacher_signed_in? }
  before_filter :authenticate_teacher!, :unless => proc { |controller| controller.user_signed_in? }
  
  def index
    @documents = Document.order_by(:module_id.asc, :published_at.asc).where(:published_at.lt => Time.now)
  end
  
end