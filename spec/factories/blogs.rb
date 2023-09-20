FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join("\n\n") }
    excerpt { Faker::Lorem.paragraph }
    association :company, factory: :company
    association :category, factory: :category
    association :author, factory: :user
  end
end
