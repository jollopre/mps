class CustomersController < ApplicationController
    def index
      meta = { count: Customer.all.count, per_page: Kaminari.config.default_per_page }
      customers = Customer.all.page(params[:page] || 1)
      render(json: { meta: meta, data: customers.as_json }, status: :ok)
    end
    def show
      begin
        customer = Customer.find(params[:id])
        render json: customer.as_json()
      rescue ActiveRecord::RecordNotFound => e
        render json: { detail: e.message }, status: :not_found
      end
    end
    # GET /customers/search/:term?page
    def search
      meta = { count: Customer.search(params[:term]).count, per_page: Kaminari.config.default_per_page }
      customers = Customer.search(params[:term]).page(params[:page] || 1)
      render(json: { meta: meta, data: customers.as_json }, status: :ok)
    end 
end