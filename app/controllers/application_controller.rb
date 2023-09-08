class ApplicationController < ActionController::Base
  puts "========================================================="
  puts APP_HOST

  before_action :set_company, if: -> { request.subdomain.present? }
  before_action :company_not_found, if: -> { request.subdomain.present? }

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_url, alert: 'Access denied'
  end

  protected

  def set_company
    @company = Company.find_by(slug: request.subdomain) if request.subdomain.present?
  end

  def company_not_found
    render404 unless @company.present?
  end

  def render404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end
end
