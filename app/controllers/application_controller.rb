class ApplicationController < ActionController::Base
  before_action :set_company, if: -> { request.subdomain.present? }
  before_action :company_not_found, if: -> { request.subdomain.present? }

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: "You don't have access to this section."
  end

  # rescue_from ActiveRecord::RecordNotFound do
  #   respond_to do |format|
  #     format.js
  #     puts 'respond with json'
  #     format.json { render json: { error: 'Record not found' }, status: :not_found }
  #     puts 'respond with html'
  #     format.html { redirect_to root_url, alert: 'Record not found' }
  #   end
  # end

  protected

  def render404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  def set_company
    @company = Company.find_by(slug: request.subdomain) if request.subdomain.present?
  end

  def company_not_found
    render404 unless @company.present?
  end
end
