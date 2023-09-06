class Category < ApplicationRecord
  belongs_to :company
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', inverse_of: :categories
  has_many :blogs, inverse_of: :category
  has_many :comments, as: :commentable

  validates :name, presence: true
  validates :company, presence: true
  validates :owner, presence: true
end
