class TeachersController < ApplicationController
  before_filter :authenticate_teacher!
  
  layout 'teacher'
  
  def index
    
  end
  
end