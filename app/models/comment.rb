class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :commentable, polymorphic: true
  belongs_to :commentor, class_name: 'User', foreign_key: 'commentor_id'
  validates :content, presence: true

  after_create :send_comment_created_email
  after_update :send_comment_updated_email
  after_destroy :send_comment_deleted_email

  private

  def send_comment_created_email
    UserMailer.with(comment: self, action: 'created').comment_email.deliver_now
  end

  def send_comment_updated_email
    UserMailer.with(comment: self, action: 'updated').comment_email.deliver_now
  end

  def send_comment_deleted_email
    UserMailer.with(comment: self, action: 'deleted').comment_email.deliver_now
  end


end
