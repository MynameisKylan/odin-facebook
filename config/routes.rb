Rails.application.routes.draw do
  root 'posts#index'

  resources :posts
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions', registrations: 'users/registrations' }
  resources :users, only: [:show, :index]
  resources :comments, only: [:create]
  resources :likes, only: [:create, :destroy]
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: [:create, :destroy]
end
