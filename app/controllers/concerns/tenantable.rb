module Tenantable
  extend ActiveSupport::Concern

  included do
    scope :for_company, ->(company) { where(company_id: company.id) }
  end
end
