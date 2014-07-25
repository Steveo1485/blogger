Rails.application.routes.draw do

  namespace :admin do
    resources :posts, only: [:index, :new, :create, :show]
  end

  resources :posts, only: [:index, :show]

  root to: "posts#index"

end
