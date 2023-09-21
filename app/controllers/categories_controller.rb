class CategoriesController < ApplicationController
  load_and_authorize_resource
  include ApplicationHelper

  # GET /categories/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /categories/:id
  def show
    @comments = @category.comments.includes(:commentor)
    @pagy, @blogs = pagy(@category.blogs)
    respond_to do |format|
      format.html
    end
  end

  # POST /categories
  def create
    success = false
    if @category.save
      message = 'Category is successfully created.'
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

  # PATCH /categories/:id
  def update
    if @category.update(category_params)
      flash.now[:notice] = 'Category is successfully updated.'
    else
      flash.now[:alert] = @category.errors.full_messages.join(', ')
    end

    respond_to do |format|
      format.js
    end
  end

  # DELETE /categories/:id
  def destroy
    begin
      @category.destroy
      if @category.destroyed?
        flash.now[:notice] = 'Category deleted successfully!'
      else
        flash.now[:alert] = 'Error while deleting category, please try again later.'
      end
    rescue ActiveRecord::InvalidForeignKey
      flash.now[:alert] = 'Unable to Delete Category: This category has associated blogs. Please delete the associated blogs before attempting to delete this category.'
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def category_params
    params.permit(:name, :company_id, :owner_id)
  end
end
