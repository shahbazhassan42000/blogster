class CommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.create(comment_params)
    @comment.save
    redirect_to blog_path(@blog)
  end
end
