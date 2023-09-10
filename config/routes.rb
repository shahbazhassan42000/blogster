Rails.application.routes.draw do
  constraints subdomain: false do
    root 'home#index'
    get 'email_confirmation', to: 'home#email_confirmation'
  end
  constraints subdomain: /.+/ do
    get '/', to: 'companies#show'
    resources :categories, except: [:show] do
      resources :blogs, except: %i[create new update destroy]
    end
    resources :user, except: %i[create destroy new] do
      resources :blogs, except: %i[index show edit]
    end
    resources :companies, except: [:show]
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  # devise_scope :user do
  #   match '/users/sign_out', controller: 'devise/sessions', action: 'destroy', via: :all
  # end
  match '*path', to: 'application#render404', via: :all, constraints: ->(req) { !req.path.starts_with?('/rails/active_storage') }
end
