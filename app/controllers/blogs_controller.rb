class BlogsController < ApplicationController
  load_and_authorize_resource
  include ApplicationHelper

  def create
    @blog = Blog.new(blog_params)
    @blog.company = current_user.company
    @blog.author = current_user

    if @blog.save
      flash[:notice] = 'Blog successfully created!'
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = @blog.errors.full_messages.join(', ')
      render 'blogs/new'
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def destroy
    @blog.destroy
    if @blog.destroyed?
      redirect_to dashboard_url(current_user), notice: 'Blog deleted successfully!'
    else
      redirect_to dashboard_url(current_user), alert: 'Error while deleting blog, please try again later.'
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to dashboard_url(current_user), notice: 'Blog updated successfully!'
    else
      redirect_to dashboard_url(current_user), alert: 'Error while updating blog, please try again later.'
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :category_id, :content, :excerpt, :featured_image)
  end
end
