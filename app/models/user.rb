class User < ApplicationRecord
  include Tenantable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: %i[owner author]

  belongs_to :company, inverse_of: :users
  has_many :blogs, inverse_of: :author, foreign_key: 'author_id'
  has_many :categories, inverse_of: :owner, foreign_key: 'owner_id', dependent: :destroy
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true
  validates :company, presence: true

  accepts_nested_attributes_for :company

  def full_name
    "#{first_name} #{last_name}"
  end
end
