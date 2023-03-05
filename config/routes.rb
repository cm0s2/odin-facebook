Rails.application.routes.draw do

  get 'friends/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :users, only: [:show]
  resources :friend_requests
  resources :friends, only: [:index, :destroy]
  resources :posts
  resources :likes, only: %i[create destroy]
end
