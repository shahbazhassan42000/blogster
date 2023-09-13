class UserMailer < ApplicationMailer
  default from: ENV['MAILER_FROM']

  def category_email
    @category = params[:category]
    @user = @category.owner
    @action = params[:action]
    mail(to: @user.email, subject: "#{'New ' if @action == 'created'}Category #{@action.capitalize}")
  end

  def blog_email
    @email_list = params[:email_list]
    @blog = params[:blog]
    @action = params[:action]

    mail(to: @email_list, subject: "#{'New ' if @action == 'published'}Blog #{@action.capitalize}")
  end
end
