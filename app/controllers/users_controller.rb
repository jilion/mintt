class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  layout 'user'
end