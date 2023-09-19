class HomeController < ApplicationController
  skip_before_action :set_company, only: [:index]
  skip_before_action :company_not_found, only: [:index]

  # GET /
  def index
    @pagy, @companies = pagy(Company.active, items: 12)
  end
end
