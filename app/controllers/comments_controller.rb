class CommentsController < ApplicationController
  load_and_authorize_resource

  # GET /comments/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash.now[:notice] = 'Comment is successfully created.'
    else
      flash.now[:alert] = @category.errors.full_messages.join(', ')
    end

    respond_to do |format|
      format.js
    end
  end

  #PATCH /comments/1
  def update
    if @comment.update(comment_params)
      flash.now[:notice] = 'Comment is successfully updated.'
    else
      flash.now[:alert] = @comment.errors.any? ? @comment.errors.full_messages.join(', ') : 'Error while updating comment, please try again later.'
    end

    respond_to do |format|
      format.js
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    if @comment.destroyed?
      flash.now[:notice] = 'Comment is successfully deleted.'
    else
      flash.now[:alert] = 'Error while deleting comment, please try again later.'
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.permit(:content, :commentable_id, :commentable_type, :company_id, :commentor_id)
  end
end
