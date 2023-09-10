class UserController < ApplicationController
  load_and_authorize_resource
  layout 'dashboard'
  def show
    puts @user.username
end
end
