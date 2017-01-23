Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#search"

  get 'index' => 'home#search'
  get 'search' => 'home#search', as: :search_home
  match 'results' => 'home#results', as: :results_home, via: [:get, :post]

  resources :manteinance_coupons, only: [:new, :create] do
    collection do
      get :similar_pauta
    end
  end

  resources :clients, only: [:new, :create, :update]

  resources :promotions, only: [:index, :show]

  resources :coupons, only: [:create]

  resources :products, only: [:index, :show]

  resources :branches_products do
    member do
      get :open_url
    end
  end

  resources :shop_inscriptions, only: [:new, :create, :update]
end
