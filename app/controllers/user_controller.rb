class UserController < ApplicationController
  load_and_authorize_resource
  layout 'dashboard'
  def new
    respond_to do |format|
      format.html
    end
  end

  def show
    @blogs = current_user.owner? ? Blog.all : current_user.blogs
    respond_to do |format|
      format.html
    end
  end
end
