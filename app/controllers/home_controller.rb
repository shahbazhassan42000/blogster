class HomeController < ApplicationController
  def index
    @pagy, @companies = pagy(Company.active) # , items: 6)
  end
end
