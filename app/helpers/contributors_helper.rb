module ContributorsHelper
  def can_request_contribution?
    current_user&.author? && @blog.author_id != current_user&.id
  end

  def is_requested?
    @blog.contributors.exists?(current_user.id)
  end
end
