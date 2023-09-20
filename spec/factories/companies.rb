FactoryBot.define do
  sequence :company_name do |n|
    "Company#{n}"
  end

  sequence :company_slug do |n|
    "company#{n}"
  end

  factory :company do
    name { generate(:company_name) }
    slug { generate(:company_slug) }
    active { true }
  end
end
