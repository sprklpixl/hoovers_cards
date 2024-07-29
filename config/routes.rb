Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'products/index'
  # get 'products/show'
  # Define routes for the Home and About pages
  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  #get 'index', to: 'pages#index' # Add this line for the index page
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "pages#home"

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

  resources :categories, only: [:index, :show]

  root 'pages#home'
  get 'about', to: 'pages#about'
end
