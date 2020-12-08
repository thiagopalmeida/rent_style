Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :products do
    get 'pause', to: 'products#pause'
    collection do
      get :my_products
    end

    resources :transactions, only: %i[new create]
    resources :reviews, only: [ :new, :create ]
  end
end
