# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
    # super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
    resource.company.update(active: true, owner: resource) if resource.owner? && resource.errors.empty?
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    email_confirmation_path
  end
end
