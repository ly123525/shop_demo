Rails.application.routes.draw do

  root 'welcomes#index'
  resources :users
  resources :sessions
  delete '/logout'=> 'sessions#destroy', as: :logout
  resources :product_categories
  resources :products

  namespace :admin do
    root 'welcomes#index'
    resources :sessions
    resources :product_categories do
      member do
        get :up, :down
      end
      resources :products
    end

    resources :products do
      resources :product_images
    end

  end
end
