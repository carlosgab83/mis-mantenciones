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

  resources :clients, only: [:new, :create]

  resources :promotions, only: [:index, :show]

  resources :coupons, only: [:create]

  resources :products, only: [:show]
end
