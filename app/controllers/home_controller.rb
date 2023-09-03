class HomeController < ApplicationController
  def index
    # show active companies
    @companies = Company.where(active: true)
  end
end
