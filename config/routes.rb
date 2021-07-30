Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  root :to => 'tasks#index'

  resources :users, only: [:new, :create, :show,]
  namespace :admin do
    resources :users
  end

  resources :sessions, only: [:new, :create, :destroy]
end
