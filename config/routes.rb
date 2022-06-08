Rails.application.routes.draw do
  root 'homes#index'

  resources :posts do
    resources :comments, only: %i[create edit update destroy], module: 'posts'
  end
end
