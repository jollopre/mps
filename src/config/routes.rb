Rails.application.routes.draw do
  resources :orders, only: [:create, :index, :show]
  resources :products, only: [:index, :show]
end
