Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :categories, only: :index do
    resources :items, only: :index
    get 'search', on: :collection
  end
  resources :items, except: :index do
    collection do
      get 'history'
      get 'chart'
      get 'search'
      get 'category_children', defaults: { format: 'json' }
    end
  end
  resources :posts do
    collection do
      get 'likes'
    end
  end
  resources :likes, only: [:create, :destroy]
  resources :declutterings, only: [:edit, :update, :show]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  # Defines the root path route ("/")
  # root "articles#index"
end
