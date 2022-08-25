Rails.application.routes.draw do
  resources :authors
  root 'home#index'
end
