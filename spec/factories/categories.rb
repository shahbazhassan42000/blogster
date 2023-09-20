FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    association :company, factory: :company
    association :owner, factory: :user
  end
end
