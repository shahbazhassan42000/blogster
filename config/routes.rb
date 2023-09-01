Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  devise_scope :user do
    match '/users/sign_out', controller: 'devise/sessions', action: 'destroy', via: :all
  end
end
