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
    if current_user.owner?
      @pagy, @blogs = pagy(Blog.includes(:category, :author).all)
    else
      blog_inclusion = Blog.includes(:category, :author)
      @pagy, @blogs = pagy(blog_inclusion.where(author_id: current_user.id).or(blog_inclusion.where(id: current_user.contributions.pluck(:id))))
    end

    respond_to do |format|
      format.html
    end
  end

  #GET /users/1/contributors
  def contributors
    @pagy, @contributors = pagy(BlogsUser.includes(:user, blog: :category, blog: :author).where(blog_id: current_user.blogs.pluck(:id)))

    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/profile
  def profile
    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/report
  def report
    @blogs = Blog.includes(:category, :author, :contributors, :comments).all

    respond_to do |format|
      format.html
    end
  end
end
