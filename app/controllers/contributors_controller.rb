class ContributorsController < ApplicationController
  before_action :set_current_user, only: %i[create update]

  # POST /categories/:category_id/blogs/:blog_id/contributors
  def create
    @contributor = BlogsUser.new(contributors_params)
    if @contributor.save
      flash.now[:notice] = 'Request for contribution sent successfully.'
    else
      flash.now[:alert] = 'Something went wrong while sending request for contribution. Please try again.'
    end

    respond_to do |format|
      format.js
    end
  end

  # PATCH /categories/:category_id/blogs/:blog_id/contributors/:id
  def update
    @contributor = BlogsUser.find(params[:id])
    if @contributor.update(status: params[:status])
      flash[:notice] = "Contributor #{params[:status]} successfully."
    else
      flash[:alert] = "Failed to #{params[:status]} contributor."
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private

  def contributors_params
    params.permit(:blog_id, :status,:user_id, :company_id)
  end
end
