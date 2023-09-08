class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :commentable, polymorphic: true
  validates :company, presence: true
  validates :content, presence: true
end
