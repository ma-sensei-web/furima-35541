Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]    
  end
  
  get 'items/index'
  get 'edits/index'
  get 'orders/index'

  # resources :users, only: [:show, :update]
  resources :users, only: [:show]
  resources :cards, only: [:new, :create]
  resources :items, only: :order do
    post 'order', on: :member
  end


end
