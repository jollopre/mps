class CustomersController < ApplicationController
    def index
      # TODO pagination
      customers = Customer.all
      render json: customers.as_json(), status: :ok
    end
    def show
      begin
        customer = Customer.find(params[:id])
        render json: customer.as_json()
      rescue ActiveRecord::RecordNotFound => e
        render json: { detail: e.message }, status: :not_found
      end
    end 
end
