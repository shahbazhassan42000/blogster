class UserController < ApplicationController
  load_and_authorize_resource
  layout 'dashboard'

  # GET /users/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /users/1
  def show
    @pagy, @blogs = pagy(current_user.owner? ? Blog.all : current_user.blogs)
    respond_to do |format|
      format.html
    end
  end

  #GET /users/1/contributors
  def contributors_show
    @contributors = current_user.owner? ? BlogsUser.all : BlogsUser.where(blog: current_user.blogs)
    respond_to do |format|
      format.html { render :contributors_show }
    end
  end
end
