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
    @pagy, @blogs = pagy(current_user.owner? ? Blog.all : Blog.where(author_id: current_user.id).or(Blog.where(id: BlogsUser.where(user_id: current_user.id).approved.pluck(:blog_id))))
    respond_to do |format|
      format.html
    end
  end

  #GET /users/1/contributors
  def contributors_show
    @pagy, @contributors = pagy(current_user.owner? ? BlogsUser.all : BlogsUser.where(blog_id: current_user.blogs.pluck(:id)))

    respond_to do |format|
      format.html { render :contributors_show }
    end
  end
end
