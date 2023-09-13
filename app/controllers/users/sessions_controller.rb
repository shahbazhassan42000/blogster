# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include CompaniesHelper
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # binding.pry
    # request.domain = "#{User.find_by(email: params[:user][:email])}.#{ENV['HOST']}"
    super
    # binding.pry
    # do |resource|
    #   if resource.persisted?
    #     domain = "#{resource.company.slug}.#{ENV['HOST']}"
    #     cookies['_blogster_session'] = {
    #       value: params[:authenticity_token],
    #       domain: domain,
    #       expires: Devise.timeout_in,
    #       secure: request.ssl?,
    #       httponly: true,
    #       hostonly: true
    #     }
    #   end
    # end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(user)
    company_url(user.company)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
