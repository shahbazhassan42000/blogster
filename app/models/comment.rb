class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :commentable, polymorphic: true
  belongs_to :commentor, class_name: 'User', foreign_key: 'commentor_id'
  validates :content, presence: true
end
