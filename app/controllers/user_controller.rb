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
    @pagy, @blogs = pagy(
      current_user.owner? ?
      Blog.all :
      Blog.includes(:category, :author).where(author_id: current_user.id).or(Blog.includes(:category, :author).where(id: current_user.contributions.pluck(:id)))
    )

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
    @report = Report.new(Blog.all)
    respond_to do |format|
      format.html
    end
  end
end
