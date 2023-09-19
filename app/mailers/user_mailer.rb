class UserMailer < ApplicationMailer
  default from: ENV['MAILER_FROM']

  def category_email
    @category = params[:category]
    @user = @category.owner
    @action = params[:action]
    mail(to: @user.email, subject: "#{'New ' if @action == 'created'}Category #{@action.capitalize}")
  end

  def blog_email
    @blog = params[:blog]
    @blog_url = "http://#{Current.user.company.slug}.#{APP_HOST}/categories/#{@blog.category.id}/blogs/#{@blog.id}"
    @action = params[:action]
    @actor = Current.user
    @email_list = [@blog.author.email, @blog.contributors.map(&:email)]
    @email_list << @blog.company.owner.email unless @blog.author.id == @blog.company.owner.id
    mail(to: @email_list, subject: "#{'New ' if @action == 'published'}Blog #{@action.capitalize}")
  end

  def comment_email
    @comment = params[:comment]
    @action = params[:action]
    @email_list = [@comment.commentor.email]
    @actor = Current.user

    if @comment.commentable_type == 'Blog'
      @email_list << @comment.commentable.author.email
      @email_list << @comment.company.owner.email unless @comment.commentable.author.id == @comment.company.owner.id
      @url = "http://#{Current.user.company.slug}.#{APP_HOST}/categories/#{@comment.commentable.category.id}/blogs/#{@comment.commentable.id}"
    else
      @email_list << @comment.company.owner.email
      @url = "http://#{Current.user.company.slug}.#{APP_HOST}/categories/#{@comment.commentable.id}"
    end
    mail(to: @email_list, subject: "#{'New ' if @action == 'created'}Comment #{@action.capitalize}")
  end

  def blog_contributor_request_email
    @blog_user = params[:blog_user]
    @action = params[:action]
    @actor = Current.user
    @email_list = [@blog_user.blog.author.email]
    @email_list << @blog_user.blog.contributors.map(&:email) unless @action == 'requested'
    @email_list << @blog_user.user.email if @action == 'rejected'

    mail(
      to: @email_list,
      subject: @action == 'requested' ? 'New Blog Contributor Request' : 'Blog Contributor Request Updated'
    )
  end
end
