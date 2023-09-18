class HomeController < ApplicationController

  # GET /
  def index
    @pagy, @companies = pagy(Company.active, items: 12)
  end
end
