class CompaniesController < ApplicationController
  load_and_authorize_resource
  def show
    @categories = Category.for_company(@company)
    @blogs = Blog.for_company(@company).order('created_at DESC').limit(50)
    @authors = User.for_company(@company).where(role: :author)
  end
end
