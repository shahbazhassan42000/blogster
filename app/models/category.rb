class Category < ApplicationRecord
  include Tenantable

  belongs_to :company
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', inverse_of: :categories
  has_many :blogs, inverse_of: :category
  has_many :comments, as: :commentable

  validates :name, presence: true
  validates :company, presence: true
  validates :owner, presence: true

  after_create :send_category_created_email
  after_update :send_category_updated_email
  after_destroy :send_category_deleted_email

  private

  def send_category_created_email
    UserMailer.with(category: self, action: 'created').category_email.deliver_now
  end

  def send_category_updated_email
    UserMailer.with(category: self, action: 'updated').category_email.deliver_now
  end

  def send_category_deleted_email
    UserMailer.with(category: self, action: 'deleted').category_email.deliver_now
  end
end
