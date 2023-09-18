class CompaniesController < ApplicationController
  load_and_authorize_resource

  # GET /companies/new
  def show
    respond_to do |format|
      format.html
    end
  end
end
