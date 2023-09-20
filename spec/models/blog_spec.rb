require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { create(:user) }
  let(:company) { create(:company, owner: user) }
  let(:category) { create(:category, company: company, owner: user) }

  before do
    allow(Current).to receive(:company).and_return(company)
  end

  let(:author_user) { create(:user, company: company, role: 'author') }

  let(:blog) { build(:blog, author: author_user, category: category, company: company) }

  it 'is valid with valid attributes' do
    expect(blog).to be_valid
  end

  it 'is not valid without a title' do
    blog.title = nil
    expect(blog).to_not be_valid
  end

  it 'is not valid without content' do
    blog.content = nil
    expect(blog).to_not be_valid
  end

  it 'is not valid without an author' do
    blog.author = nil
    expect(blog).to_not be_valid
  end

  it 'belongs to current company' do
    expect(blog.company).to eq(Current.company)
  end

  it 'belongs to a category' do
    expect(blog.category).to be_instance_of(Category)
  end

  it 'belongs to an author' do
    expect(blog.author).to be_instance_of(User)
  end

  before do
    allow(Current).to receive(:user).and_return(author_user)
  end

  it 'sends email after creation' do
    expect(ActionMailer::Base.deliveries.count).to eq(2)
  end
end
