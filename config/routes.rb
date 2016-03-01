Rails.application.routes.draw do
  root to: "restaurants#index"

  # get "/auth/:provider/callback", to: "sessions#create"
  # get "/auth/failure", to: redirect("/")
  # get "/signout", to: "sessions#destroy", as: "signout"
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" } #, path_names: {sign_in: "login"}

  resources :restaurants
  resources :authentications, only: [:index, :show, :destroy]
end
