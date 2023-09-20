class BlogsUser < ApplicationRecord
  default_scope { where(company_id: Current.company.id).order(status: :asc) }

  belongs_to :blog
  belongs_to :user
  belongs_to :company

  enum status: %i[pending approved rejected]

  validates :status, presence: true

  scope :pending, -> { where(status: :pending) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }

  after_create :send_blog_contributor_request_email
  after_update :send_blog_contributor_request_status_email

  private

  def send_blog_contributor_request_email
    UserMailer.with(blog_user: self, action: 'requested').blog_contributor_request_email.deliver_now
  end

  def send_blog_contributor_request_status_email
    UserMailer.with(blog_user: self, action: status).blog_contributor_request_email.deliver_now
  end
end
