class ContributorsController < ApplicationController
  # POST /contributors
  def create
    success = false
    @contributor = BlogsUser.new(contributors_params)
    if @contributor.save
      message = 'Your request for contribution is successfully sent.'
      success = true
    else
      message = 'Something went wrong while sending request for contribution. Please try again.'
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
    success = false
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
    params.permit(:blog_id, :user_id, :company_id)
  end
end
