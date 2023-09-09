class CompaniesController < ApplicationController
  load_and_authorize_resource
  def show
    @categories = Category.for_company(@company)
  end
end
