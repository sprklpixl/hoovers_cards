Rails.application.routes.draw do
  get 'carts/show'
  get 'carts/add_item'
  get 'carts/remove_item'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define routes for the Home, About, and Contact pages
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  #get 'index', to: 'pages#index' # Add this line for the index page
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#home'

  # Resources for Products and Categories
  resources :products, only: [:index, :search]
  resources :categories, only: [:index]

  # Adding Search with dropdown for categories
  resources :products do
    collection do
      get 'search'
      get 'by_category/:category_id', to: 'products#by_category', as: 'by_category'
    end
  end

  resources :categories, only: [:index, :search]

  # Adding Cart and Order routes
  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item', to: 'carts#remove_item'
  end

  resources :orders, only: [:new, :create, :show]
end
