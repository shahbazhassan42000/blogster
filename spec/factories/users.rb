FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'hum-2977' }
    username { Faker::Internet.unique.username }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    role { 'owner' }
    association :company, factory: :company
  end
end
