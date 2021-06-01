Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'items/index'
  get 'edits/index'
  get 'orders/index'
  get 'news/index'

  devise_for :users

  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
  end

  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  resources :items, only: :order do
    post 'order', on: :member
  end
end
