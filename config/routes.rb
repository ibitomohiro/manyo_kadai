Rails.application.routes.draw do
  resources :tasks
  resources :users, only: [:new, :create]
  root to: 'tasks#index'
end
