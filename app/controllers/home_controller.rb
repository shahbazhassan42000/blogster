class HomeController < ApplicationController
  def index
    @companies = Company.where(active: true)
  end
end
