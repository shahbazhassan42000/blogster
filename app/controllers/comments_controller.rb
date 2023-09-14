class CommentsController < ApplicationController
  def new
    respond_to do |format|
      format.html
    end
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    success = false
    if @comment.save
      message = 'Comment is successfully created.'
      success = true
    else
      message = @category.errors.full_messages.join(', ')
    end

    respond_to do |format|
      if success
        format.js { flash.now[:notice] = message }
      else
        format.js { flash.now[:alert] = message }
      end
    end
  end

  private

  def comment_params
    params.permit(:content, :commentable_id, :commentable_type, :company_id)
  end
end
