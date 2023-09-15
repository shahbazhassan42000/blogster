class BlogsUser < ApplicationRecord
  # , status: :approved
  default_scope { where(company_id: Current.company.id).order(status: :asc) }

  belongs_to :blog
  belongs_to :user
  belongs_to :company

  enum status: %i[pending approved rejected]

  validates :status, presence: true

  scope :pending, -> { where(status: :pending) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }
  scope :by_blog, ->(blog) { where(blog: blog) }
end
