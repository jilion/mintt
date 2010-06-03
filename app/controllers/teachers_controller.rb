class TeachersController < ApplicationController
  before_filter :authenticate_teacher!
  
  layout 'teacher'
end