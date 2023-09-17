module ContributorsHelper
  def can_request_contribution?
    current_user&.author? && @blog.author_id != current_user&.id
  end

  def is_requested?
    @blog.contributors.exists?(current_user.id)
  end

  def pending_requests_count
    current_user.owner? ? BlogsUser.pending.count : BlogsUser.pending.where(blog_id: current_user.blogs.pluck(:id)).count
  end
end
