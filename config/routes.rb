Rails.application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" } #, path_names: {sign_in: "login"}

  resources :restaurants
  resources :authentications, only: [:index, :show, :destroy]
end
