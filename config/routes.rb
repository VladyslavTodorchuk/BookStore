Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  devise_for :users, as: 'omniauth', controller: { omniauth_callbacks: 'callbacks' }

  root 'home#index'

  resources :users

  resources :books, only: %i[show index] do
    resources :reviews, only: :create
  end
end
