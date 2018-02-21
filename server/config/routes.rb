Rails.application.routes.draw do
  scope '/api' do
    # customers
    resources :customers, only: [:index, :show] do
        collection do
            get 'search/:term', action: :search
        end
    end
    # feature_values
    resources :feature_values, only: [:update]
    
    # orders
    resources :orders, only: [:create, :index, :show] do
        collection do
            get 'search/:term', action: :search
        end
    	# order_items shadow nesting
    	resources :order_items, only: [:index, :create]
    end

    # order_items actions that do not need hierarchy
    resources :order_items, only: [:show, :update] do
      get 'export', on: :member
    end

    # products
    resources :products, only: [:index, :show]

    # users
    post 'sign-in', to: 'users#sign_in'
    delete 'sign-out', to: 'users#sign_out'
  end
end
