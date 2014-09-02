Rails.application.routes.draw do

  devise_for :users
  namespace :admin do
    resources :posts

    resources :users, only: [:index]

    get "/", to: "posts#index"
  end

  resources :posts, only: [:index, :show]

  root to: "posts#index"

end
