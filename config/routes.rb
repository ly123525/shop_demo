Rails.application.routes.draw do
  get 'sessions/new'

  root 'welcomes#index'
  resources :users
  resources :sessions
  delete '/logout'=> 'sessions#destroy', as: :logout
end
