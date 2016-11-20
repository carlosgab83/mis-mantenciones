Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#search"

  get 'index' => 'home#search'
  get 'search' => 'home#search', as: :search_home
  match 'results' => 'home#results', as: :results_home, via: [:get, :post]

  resources :manteinance_coupons, only: [:new, :create], defaults: {format: :json}

  resources :clients, only: [:create], defaults: {format: :json}

  resources :promotions, only: [:index, :show]

  resources :coupons, only: [:create], defaults: {format: :json}
end
