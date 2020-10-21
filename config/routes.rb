Rails.application.routes.draw do
  root 'posts#index'

  resources :posts
  devise_for :users
  resources :users, only: [:show, :index]
  resources :comments, only: [:create]
  resources :likes, only: [:create, :destroy]
  resources :friend_requests, only: [:create, :destroy]
end
