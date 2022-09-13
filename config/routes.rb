Rails.application.routes.draw do
  devise_for :users

  devise_for :users, controller: { omniauth_callbacks: 'callbacks' }

  root 'home#index'

  resources :books, only: %i[show index]
end
