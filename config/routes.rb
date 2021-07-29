Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  root :to => 'tasks#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
