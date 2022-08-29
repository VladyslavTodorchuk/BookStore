Rails.application.routes.draw do
  root 'home#index'

  resources :books, only: %i[show index]
  # get 'books/category/:id', to: 'books#index'
end
