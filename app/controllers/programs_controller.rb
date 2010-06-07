class ProgramsController < ApplicationController
  before_filter :authenticate_user!, :unless => proc { |controller| controller.teacher_signed_in? }
  before_filter :authenticate_teacher!, :unless => proc { |controller| controller.user_signed_in? }
  
  def index
    @documents = Document.all(:published_at.lt => Time.now, :order => 'module_id ASC, published_at ASC')
  end
  
end