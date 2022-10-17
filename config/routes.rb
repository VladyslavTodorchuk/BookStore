Rails.application.routes.draw do
  root 'home#index'

  resources :books, only: %i[show index]
end
