Rails.application.routes.draw do

  root "static_pages#home"
  devise_for :users
  resources :authors
  resources :book_authors
  resources :categories
  resources :publishers
  resources :books
  resources :book_carts
  resources :carts
  namespace :admin do
    resources :users
  end
end
