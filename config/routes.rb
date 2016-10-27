Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#search"

  get 'index' => 'home#search'
  get 'search' => 'home#search', as: :search_home
  match 'results' => 'home#results', as: :results_home, via: [:get, :post]
end
