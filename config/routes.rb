Rails.application.routes.draw do

  resources :order_items
  get "/cart_index", to: "session_carts#index"
  get "/cart_create", to: "session_carts#create"
  get "/cart_destroy", to: "session_carts#destroy"

  resources :orders
  devise_for :users
  resources :authors
  resources :book_authors
  resources :categories
  resources :publishers
  root "static_pages#home"
  resources :books
  namespace :admin do
    resources :users
  end
end
