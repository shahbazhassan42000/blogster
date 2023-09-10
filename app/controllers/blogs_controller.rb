class BlogsController < ApplicationController
  load_and_authorize_resource
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
  private

  def blog_params
    params.require(:blog).permit(:title, :category_id, :content, :excerpt, :featured_image)
  end
end
