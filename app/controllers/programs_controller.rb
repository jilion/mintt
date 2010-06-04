class ProgramsController < ApplicationController
  before_filter :authenticate_user! unless teacher_signed_in?
  before_filter :authenticate_teacher! unless user_signed_in?
  
  layout 'program'
  
  def index
  end
  
end