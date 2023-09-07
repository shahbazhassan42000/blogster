Rails.application.routes.draw do
  constraints subdomain: false do
    root 'home#index'
    # resources :blogs, except: [:show] do
    #   post 'update_contributors' => 'blogs#update_contributors'
    # end
    # get 'search', to: 'blogs#search'
  end
  constraints subdomain: /.+/ do
    get '/', to: 'companies#show'
    resources :blogs
    resources :companies, except: [:show]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  devise_scope :user do
    match '/users/sign_out', controller: 'devise/sessions', action: 'destroy', via: :all
  end
  match '*unmatched', to: 'application#render404', via: :all
end
