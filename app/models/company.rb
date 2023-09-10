class Company < ApplicationRecord
  has_many :users, inverse_of: :company
  has_many :categories, inverse_of: :company
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+\Z/ }
  has_one_attached :logo
  has_one_attached :banner

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
