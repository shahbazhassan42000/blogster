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
    @action = params[:action]
    @email_list = [@blog.author.email, @blog.company.owner.email, @blog.contributors.map(&:email)]

    mail(to: @email_list, subject: "#{'New ' if @action == 'published'}Blog #{@action.capitalize}")
  end
end
