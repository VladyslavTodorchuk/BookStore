Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :books, only: %i[show index]
end
