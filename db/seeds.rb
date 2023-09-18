require 'faker'

# i = 1
# j = 1
# adding owners
20.times do
  company_name = Faker::Company.name
  user = User.create!(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    # avatar: {
    #   io: File.open(Rails.root.join('app', 'assets', 'images', 'data', "user_#{i}.jpg")),
    #   filename: "user_#{i}.jpg"
    # },
    password: 'hum-2977',
    company_attributes: {
      name: company_name,
      slug: company_name.gsub(/[^a-zA-Z0-9]/, '').downcase,

      # logo: {
      #   io: File.open(Rails.root.join('app', 'assets', 'images', 'data', "user_#{i + 1}.jpg")),
      #   filename: "user_#{i}.jpg"
      # },
      # banner: {
      #   io: File.open(Rails.root.join('app', 'assets', 'images', 'data', "banner_#{j}.jpg")),
      #   filename: "user_#{i}.jpg"
      # },
      active: true
    }
  )
  user.confirm
  user.company.update(owner: user)
  # i += 2
  # j += 1
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
    # avatar: {
    #   io: File.open(Rails.root.join('app', 'assets', 'images', 'data', "user_#{i}.jpg")),
    #   filename: "user_#{i}.jpg"
    # },
    role: :author
  )
  user.confirm

  # i += 1
  # i = 1 if i > 81
  # add blogs
  5.times do
    Blog.create!(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraphs.join("\n\n"),
      company_id: user.company.id,
      author_id: user.id,
      category: user.company.categories.sample,
      excerpt: Faker::Lorem.paragraph,
      # featured_image: {
      #   io: File.open(Rails.root.join('app', 'assets', 'images', 'data', "banner_#{j}.jpg")),
      #   filename: "banner_#{j}.jpg"
      # }
    )
    # i += 1
    # i = 1 if i > 81
    # j += 1
  end
end
