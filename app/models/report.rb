class Report
  attr_reader :blogs

  def initialize(blogs)
    @blogs = []
    blogs.each do |blog|
      @blogs << {
        title: blog.title,
        category: blog.category.name,
        comments_count: blog.comments.count,
        author: blog.author.username,
        status: blog.status,
        contributors_count: blog.contributors.count,
        contributors: blog.contributors.map(&:username),
        created_at: blog.created_at,
        updated_at: blog.updated_at
      }
    end
  end
end
