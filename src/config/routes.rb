Rails.application.routes.draw do

  # orders
  resources :orders, only: [:create, :index, :show] do
  	# order_items shadow nesting
  	resources :order_items, only: [:index, :create]
  end

  # order_items actions that do not need hierarchy
  resources :order_items, only: [:show, :update]

  # products
  resources :products, only: [:index, :show]
end
