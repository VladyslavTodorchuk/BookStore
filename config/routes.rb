Rails.application.routes.draw do
  devise_for :users, controller: { omniauth_callbacks: 'callbacks' }

  devise_for :users, as: 'omniauth', controller: { omniauth_callbacks: 'callbacks' }

  root 'home#index'

  resources :users

  resources :books, only: %i[show index]
end
