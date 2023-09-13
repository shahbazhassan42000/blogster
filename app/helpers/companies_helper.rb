module CompaniesHelper
  def company_url(company)
    "http://#{company.slug}.#{APP_HOST}"
  end
end
