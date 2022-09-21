Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  devise_for :users, as: 'omniauth', controller: { omniauth_callbacks: 'callbacks' }

  root 'home#index'

  resources :order, only: %i[index edit] do
    get '/add_to_cart', to: 'order_book#add_to_order'
    get '/delete_from_cart', to: 'order_book#delete_product'
  end

  resources :users

  resources :books, only: %i[show index] do
    resources :reviews, only: :create
  end
end
