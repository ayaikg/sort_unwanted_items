Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'privacy', to: 'homes#privacy'
  get 'terms', to: 'homes#terms'
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :categories, only: :index do
    resources :items, only: :index
  end
  resources :items, except: :index do
    collection do
      get 'history'
      get 'search'
      get 'category_children', defaults: { format: 'json' }
    end
  end
  resources :posts do
    get 'likes', on: :collection
  end
  resources :likes, only: [:create, :destroy]
  resources :declutterings, only: [:edit, :update, :show]
  resource :recommend, only: :show

  namespace :admin do
    root to: 'users#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :posts, only: %i[index edit update show destroy]
    resources :users, only: %i[edit update show destroy]
    resources :items, only: %i[index edit update show destroy] do
      get 'category_children', defaults: { format: 'json' }, on: :collection
    end
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider

  # Defines the root path route ("/")
  # root "articles#index"
end
