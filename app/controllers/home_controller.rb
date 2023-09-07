class HomeController < ApplicationController
  skip_before_action :set_company
  def index
    # show active companies
    @companies = Company.where(active: true)
  end
end
