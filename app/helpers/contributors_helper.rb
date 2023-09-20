module ContributorsHelper
  def can_request_contribution?
    current_user&.author? && @blog.author_id != current_user&.id
  end

  def is_requested?
    BlogsUser.where(blog_id: @blog.id, user_id: current_user.id, status: %i[pending approved]).exists?
  end

  def pending_requests_count
    BlogsUser.pending.where(blog_id: current_user.blogs.pluck(:id)).count
  end
end
