class ProgramsController < ApplicationController
  # include Devise::Controllers::InternalHelpers
  
  before_filter :authenticate_user!, :unless => proc { |controller| controller.signed_in? :teacher }
  before_filter :authenticate_teacher!, :unless => proc { |controller| controller.signed_in? :user }
  
  layout 'program'
  
  def index
    @documents = Document.all(:published_at.lt => Time.now, :order => 'module_id asc, published_at asc')
  end
  
end