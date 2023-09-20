class Blog < ApplicationRecord
  default_scope { where(company_id: Current.company.id) }

  belongs_to :company
  belongs_to :category, inverse_of: :blogs
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, as: :commentable
  has_many :blogs_users, -> { where(status: :approved) }, dependent: :destroy
  has_many :contributors, through: :blogs_users, source: :user, dependent: :destroy
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
  scope :recent, -> { order(created_at: :desc).limit(50) }

  after_create :send_blog_created_email
  after_update :send_blog_updated_email
  after_destroy :send_blog_deleted_email

  private

  def send_blog_created_email
    UserMailer.with(email_to: author.email, blog: self, action: 'published').blog_email.deliver_now
    UserMailer.with(email_to: company.owner.email, blog: self, action: 'published').blog_email.deliver_now unless author.id == company.owner.id
  end

  def send_blog_updated_email
    UserMailer.with(email_to: author.email, blog: self, action: 'updated').blog_email.deliver_now
    UserMailer.with(email_to: company.owner.email, blog: self, action: 'updated').blog_email.deliver_now unless author.id == company.owner.id
    contributors.each do |contributor|
      UserMailer.with(email_to: contributor.email, blog: self, action: 'updated').blog_email.deliver_now
    end
  end

  def send_blog_deleted_email
    UserMailer.with(email_to: author.email, blog: self, action: 'deleted').blog_email.deliver_now
    UserMailer.with(email_to: company.owner.email, blog: self, action: 'deleted').blog_email.deliver_now unless author.id == company.owner.id
    contributors.each do |contributor|
      UserMailer.with(email_to: contributor.email, blog: self, action: 'deleted').blog_email.deliver_now
    end
  end
end
