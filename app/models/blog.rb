class Blog < ApplicationRecord
  include Tenantable

  belongs_to :company
  belongs_to :category, inverse_of: :blogs
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, as: :commentable
  has_and_belongs_to_many :contributors, class_name: 'User', join_table: 'blogs_users'
  has_one_attached :featured_image

  enum status: %i[published archived]

  validates :title, presence: true
  validates :content, presence: true
  validates :company, presence: true
  validates :category, presence: true
  validates :author, presence: true

  scope :published, -> { where(status: :published) }
  scope :archived, -> { where(status: :archived) }
  scope :by_author, ->(author) { where(author) }
  scope :by_category, ->(category) { where(category) }
end
