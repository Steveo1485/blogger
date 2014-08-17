Rails.application.routes.draw do

  namespace :admin do
    resources :posts
  end

  resources :posts, only: [:index, :show]

  root to: "posts#index"

end
