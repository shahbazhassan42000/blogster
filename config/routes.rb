Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  devise_scope :user do
    match '/users/sign_out', controller: 'devise/sessions', action: 'destroy', via: :all
  end
end
