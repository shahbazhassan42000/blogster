class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true, uniqueness: true

  has_one :company, foreign_key: 'owner_id', inverse_of: :owner, dependent: :destroy

  accepts_nested_attributes_for :company

  private

  def full_name
    "#{first_name} #{last_name}"
  end

end
