class ApplicationController < ActionController::Base
  puts "========================================================="
  puts APP_HOST

  before_action :set_company

  def set_company
    @company = Company.find_by(slug: request.subdomain) if request.subdomain.present?
    render404 unless @company.present?
  end

  def render404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end
end
