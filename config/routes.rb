Rails.application.routes.draw do
  constraints subdomain: false do
    root 'home#index'
  end
  constraints subdomain: /.+/ do
    get '/', to: 'companies#show'
    resources :categories do
      resources :blogs, except: %i[create new] do
        resources :contributors, only: %i[create destroy update]
      end
    end
    resources :comments
    resources :user, except: %i[create destroy new] do
      resources :blogs, only: %i[create new]
      get 'contributors', to: 'user#contributors'
      get 'profile', to: 'user#profile'
      get 'report', to: 'user#report'
    end
    resources :companies, except: [:show]
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions'
  }
  # devise_scope :user do
  #   match '/users/sign_out', controller: 'devise/sessions', action: 'destroy', via: :all
  # end
  match '*path', to: 'application#render404', via: :all, constraints: ->(req) { !req.path.starts_with?('/rails/active_storage') }
end
