Rails.application.routes.draw do

  root 'welcomes#index'
  resources :users
  resources :sessions
  delete '/logout'=> 'sessions#destroy', as: :logout
  resources :product_categories
  resources :products
  resources :shopping_carts
  resources :addresses do
    member do
      put :set_default_address
    end
  end
  resources :orders
  resources :payments do
    collection do
      get :generate_pay
      get :pay_return
      get :pay_notify
      get :success
      get :failed
    end
  end
  resources :cellphone_tokens
  namespace :dashboard do
    scope 'profile' do
      controller :profile do
        get :password
        put :update_password
      end
    end
    resources :orders
    resources :addresses
  end
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
