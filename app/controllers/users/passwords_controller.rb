# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  include CompaniesHelper
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  def after_resetting_password_path_for(resource)
    user_company_url = company_url(current_user.company)
    sign_out current_user # force sign out to prevent sign in at root_url
    flash.delete(:notice)
    # flash.now[:notice] = 'Password successfully updated, please sign in again.' # NOT WORKING
    "#{user_company_url}/users/sign_in"
  end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
