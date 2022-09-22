Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  devise_for :users, as: 'omniauth', controller: { omniauth_callbacks: 'callbacks' }

  root 'home#index'

  resources :orders, only: %i[index edit] do
    get '/add_to_order', to: 'order_books#add_to_order'
    delete '/delete_from_cart/:book_id', to: 'order_books#delete_product'
    put '/order_update_book/:book_id', to: 'order_books#update'
  end

  get '/coupon_check', to: 'coupons#find'

  resources :users

  resources :books, only: %i[show index] do
    resources :reviews, only: :create
  end
end
