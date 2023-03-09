Rails.application.routes.draw do
  get 'static_pages/home'
  get 'profiles/edit'
  get 'profiles/update'

  get 'friends/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "static_pages#home"
  resources :users, only: [:show]
  get 'profile', to: 'users#show'
  resources :friend_requests
  resources :friends, only: [:index, :destroy]
  resources :posts
  resources :likes, only: %i[create destroy]
  resources :comments, only: %i[create destroy]
  resource :profile, only: %i[edit update]
end
