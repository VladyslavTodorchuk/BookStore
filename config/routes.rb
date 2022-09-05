require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  ActiveAdmin.routes(self)

  devise_for :users

  devise_for :users, as: 'omniauth', controller: { omniauth_callbacks: 'callbacks' }

  root 'home#index'
<<<<<<< HEAD
  
  resources :orders, only: %i[index] do
    get '/add_to_order', to: 'order_books#add_to_order'
    delete '/delete_from_cart/:book_id', to: 'order_books#delete_product'
    put '/order_update_book', to: 'order_books#update_quantity'
  end

  get '/coupon_check', to: 'coupons#find'
  
=======

>>>>>>> 3b03895 (Featire specs)
  resources :users

  resources :books, only: %i[show index] do
    resources :reviews, only: :create
  end
end
