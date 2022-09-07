Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :users
=======
  devise_for :users, controller: { omniauth_callbacks: 'callbacks' }

>>>>>>> c3cc5e4 (Add Facbook omniauth)
  root 'home#index'

  resources :books, only: %i[show index]
end
