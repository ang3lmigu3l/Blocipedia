Rails.application.routes.draw do

  resources :wikis
  get '/private_wikis' => 'wikis#private'
  resources :charges
  delete 'subscriptions/', to: 'charges#destroy', as: :subscription
  devise_for :users
  resources :users, :only => [:show]

  get '/about' => 'welcome#about'

  authenticated :user do
    root to: "wikis#index", as: :authenticated_root
  end
  root 'welcome#index'

end
