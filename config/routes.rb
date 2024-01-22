# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web' # This line is written for sidekiq
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  mount Sidekiq::Web => '/sidekiq' # This is route for sidekiq
  devise_for :users

  resources :folders do
    resources :qrs
  end

  resources :qrs

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
