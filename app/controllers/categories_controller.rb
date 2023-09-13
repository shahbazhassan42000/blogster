class CategoriesController < ApplicationController
  load_and_authorize_resource
  include ApplicationHelper

  def new
    respond_to do |format|
      format.html
    end
  end

  def show
    @pagy, @blogs = pagy(@category.blogs)
    respond_to do |format|
      format.html
    end
  end

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

  def update
    respond_to do |format|
      if @category.update(category_params)
        message = 'Category is successfully updated.'
        format.js { flash.now[:notice] = message }
        format.json { render json: message, status: :ok }
        format.html { redirect_to company_url(@company), notice: message }
      else
        message = 'Error while updating category, please try again later.'
        format.js { flash.now[:alert] = message }
        format.json { render json: message, status: :unprocessable_entity }
        format.html { redirect_to company_url(@company), alert: message }
      end
    end
  end

  def destroy
    respond_to do |format|
      begin
        @category.destroy
        if @category.destroyed?
          message = 'Category is successfully deleted.'
          format.js { flash.now[:notice] = message }
          format.json { head :no_content }
          format.html { redirect_to company_url(@company), notice: message }
        else
          message = 'Error while deleting category, please try again later.'
          format.js { flash.now[:alert] = message }
          format.json { render json: message, status: :unprocessable_entity }
          format.html { redirect_to company_url(@company), alert: message }
        end
      rescue ActiveRecord::InvalidForeignKey
        message = 'Unable to Delete Category: This category has associated blogs. Please delete the associated blogs before attempting to delete this category.'
        format.js { flash.now[:alert] = message }
        format.json { render json: message, status: :unprocessable_entity }
        format.html { redirect_to company_url(@company), alert: message }
      end
    end
  end

  private

  def category_params
    params.permit(:name, :company_id, :owner_id)
  end
end
