class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_company, if: -> { request.subdomain.present? }
  before_action :company_not_found, if: -> { request.subdomain.present? }

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: "You don't have access."
  end

  rescue_from ActiveRecord::RecordNotFound do
    render404
  end

  def render404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end

  private

  def set_company
    Current.company = Company.find_by(slug: request.subdomain)
  end

  def set_current_user
    Current.user = current_user
  end

  def company_not_found
    render404 unless Current.company.present?
  end
end
