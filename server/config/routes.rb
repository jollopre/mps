Rails.application.routes.draw do
  scope '/api' do
    # customers
    resources :customers, only: [:index, :show, :update] do
        collection do
            get 'search/:term', action: :search
        end
    end
    # feature_values
    resources :feature_values, only: [:update]

    # quotations
    resources :quotations, only: [:create, :index, :show] do
        collection do
            get 'search/:term', action: :search
        end
    	# enquiries shadow nesting
    	resources :enquiries, only: [:index, :create]
    end

    # enquiries actions that do not need hierarchy
    resources :enquiries, only: [:show, :update, :destroy] do
      get 'export', on: :member
    end

    # products
    resources :products, only: [:index, :show]

    # suppliers
    resources :suppliers, only: [:index]

    # composed_emails
    resources :composed_emails, only: [:create, :show, :update] do
      member do
        post 'send_email'
      end
    end

    # users
    post 'sign-in', to: 'users#sign_in'
    delete 'sign-out', to: 'users#sign_out'
  end
end
