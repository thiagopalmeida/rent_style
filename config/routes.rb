Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products, only: %i[new create show index] do

    collection do
      get :my_products
    end

    resources :transactions, only: [:new, :create]
  resources :products do
    resources :transactions, only: %i[new create]

  end

  
end
