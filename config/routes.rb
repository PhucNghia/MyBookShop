Rails.application.routes.draw do

  devise_for :users
  resources :authors
  resources :book_authors
  resources :categories
  resources :publishers
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/bookshow", to: "books#show"
  resources :books
  resources :book_carts
  resources :carts
  resources :users
  namespace :admin do
    resources :users, except: [:index, :show]
  end
end
