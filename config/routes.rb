Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  get 'my_pauta' => 'home#my_pauta', as: :my_pauta_home
  match 'results' => 'home#results', as: :results_home, via: [:get, :post]
  get 'blog' => 'promotions#blog', as: :blog

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

  resources :search_products, :path => '/search-products', only: [:index, :show, :update] do
    collection do
      get :model_collection
    end
  end

  resources :search_branches, :path => '/search-branches', only: [:index, :create, :show] do
    collection do
      get :model_collection
    end
  end

  resources :shops, only: [] do
    resources :branches, only: [] do
      resources :promotions, only: [:show, :index], module: :branches_promotions do
      end
    end
  end

  resources :shop_inscriptions, :path => '/registro-taller', only: [:new, :create, :update]

  # Error Handling
  if Rails.env.production?
   match '400' => "home#search", via: [:get, :post, :put, :patch, :delete]
   match '401' => "home#search", via: [:get, :post, :put, :patch, :delete]
   match '404' => "home#search", via: [:get, :post, :put, :patch, :delete]
   match '422' => "home#search", via: [:get, :post, :put, :patch, :delete]
   match '500' => "home#search", via: [:get, :post, :put, :patch, :delete]
  end

  # General Purpose traking entry-point for some frontend events
  resources :frontend_tracking, only: [:create]
end
