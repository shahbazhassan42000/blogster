class BlogsController < ApplicationController
  load_and_authorize_resource
  include ApplicationHelper
  before_action :set_current_user, only: %i[create update destroy]

  # GET /user/:user_id/blogs/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # POST /user/:user_id/blogs
  def create
    binding.pry
    success = false
    if @blog.save
      flash[:notice] = 'Blog successfully created!'
      success = true
    else
      flash.now[:alert] = @blog.errors.full_messages.join(', ')
    end

    respond_to do |format|
      if success
        format.html { redirect_to user_path(current_user) }
      else
        format.html { render 'blogs/new' }
      end
    end
  end

  # GET /categories/:category_id/blogs/:id
  def show
    @comments = @blog.comments.includes(:commentor)
    respond_to do |format|
      format.html
    end
  end

  # DELETE /categories/:category_id/blogs/:id
  def destroy
    @blog.destroy
    if @blog.destroyed?
      flash[:notice] = 'Blog deleted successfully!'
    else
      flash[:alert] = 'Error while deleting blog, please try again later.'
    end

    respond_to do |format|
      format.html { redirect_to dashboard_url(current_user) }
    end
  end

  # PATCH /categories/:category_id/blogs/:id
  def update
    if @blog.update(blog_params)
      flash[:notice] = 'Blog updated successfully!'
    else
      flash[:alert] = 'Error while updating blog, please try again later.'
    end

    respond_to do |format|
      format.html { redirect_to dashboard_url(current_user) }
    end
  end

  private

  def blog_users_email_list
    users = []
    users << @blog.author.email
    users << @blog.company.owner.email
  end

  def blog_params
    params.require(:blog).permit(:title, :company_id, :author_id, :category_id, :content, :excerpt, :featured_image)
  end
end
