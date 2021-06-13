Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'items/index'
  get 'edits/index'
  get 'orders/index'
  get 'news/index'
  get 'items/search'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  root to: 'items#index'
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
  end

  resources :users, only: [:show, :update, :new]
  resources :cards, only: [:new, :create]
  resources :items, only: :order do
    post 'order', on: :member
  end
end
