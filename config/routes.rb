Rails.application.routes.draw do

  devise_for :users
  namespace :admin do
    resources :posts

    resources :users, except: [:show, :new]

    get "/", to: "posts#index"
  end

  resources :posts, only: [:index, :show]

  root to: "posts#index"

end
