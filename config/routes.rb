Rails.application.routes.draw do

  devise_for :users
  root to: "plants#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resource :users
  resources :plants, only: [:index, :show]
  get 'cart', to: 'pages#cart', as: :cart
  resource :cart, only: [:show] do
    resources :orders, only: [:new]
  end
  post 'cart/add'
  delete 'cart/remove', to: 'cart#remove', as: :cart_remove
  patch 'cart/increment_quantity/:id', to: 'cart#increment_quantity', as: :increment_quantity_cart
  patch 'cart/decrement_quantity/:id', to: 'cart#decrement_quantity', as: :decrement_quantity_cart

  # Defines the root path route ("/")
  # root "posts#index"
end
