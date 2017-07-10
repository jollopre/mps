class CustomersController < ApplicationController
    def index
        # TODO pagination
        customers = Customer.all
        render json: customers.as_json(), status: :ok
    end
end
