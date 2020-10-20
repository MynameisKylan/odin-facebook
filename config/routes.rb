Rails.application.routes.draw do
  root 'posts#index'

  resources :posts
  devise_for :users
  resources :users, only: [:show]
  resources :comments, only: [:create]
end
