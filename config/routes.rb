Rails.application.routes.draw do
  get 'users/show'

  resources :wikis
  resources :charges
  delete 'subscriptions/', to: 'charges#destroy', as: :subscription
  devise_for :users

  get '/about' => 'welcome#about'

  authenticated :user do
    root to: "wikis#index", as: :authenticated_root
  end
  root 'welcome#index'

end
