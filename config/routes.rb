Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resources :users, only: [:new, :create]
  resources :categories, except: :show do
    resources :items, only: [:index]
  end
  resources :items, only: [:new, :create, :edit, :show, :destroy]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  # Defines the root path route ("/")
  # root "articles#index"
end