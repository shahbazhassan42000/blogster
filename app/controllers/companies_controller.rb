class CompaniesController < ApplicationController
  load_and_authorize_resource

  # GET /companies/new
  def show
    Current.company = Company.includes(:categories).find_by(slug: request.subdomain)
    respond_to do |format|
      format.html
    end
  end
end
