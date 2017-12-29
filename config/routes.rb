Rails.application.routes.draw do

  resources :authors
  resources :book_authors
  resources :categories
  resources :publishers
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/bookshow", to: "books#show"
  resources :books
  resources :book_carts
  resources :carts
  resources :users
  namespace :admin do
    resources :users, except: [:index, :show]
  end
end
