# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# adding owners
20.times do
  company_name = Faker::Company.name
  user = User.create!(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: 'hum-2977',
    company_attributes: {
      name: company_name,
      slug: company_name.gsub(/[^a-zA-Z0-9]/, '').downcase,
      active: true
    }
  )
  user.confirm
  user.company.update(owner: user)
  # add categories
  5.times do
    Category.create!(
      name: Faker::Company.industry,
      company: user.company,
      owner: user
    )
  end
end

# adding authors
20.times do
  user = User.create!(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: 'hum-2977',
    company: Company.all.sample,
    role: :author
  )
  user.confirm

  # add blogs
  5.times do
    Blog.create!(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraphs.join("\n\n"),
      company: user.company,
      author: user,
      category: user.company.categories.sample,
      excerpt: Faker::Lorem.paragraph
    )
  end
end
