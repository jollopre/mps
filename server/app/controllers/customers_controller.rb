class CustomersController < ApplicationController
  def index
    meta = { count: Customer.all.count, per_page: Kaminari.config.default_per_page }
    customers = Customer.all.page(params[:page] || 1)
    render(json: { meta: meta, data: customers.as_json }, status: :ok)
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer.as_json()
  rescue ActiveRecord::RecordNotFound => e
    render json: { detail: e.message }, status: :not_found
  end

  def search
    meta = { count: Customer.search(params[:term]).count, per_page: Kaminari.config.default_per_page }
    customers = Customer.search(params[:term]).page(params[:page] || 1)
    render(json: { meta: meta, data: customers.as_json }, status: :ok)
  end

  def update
    customer = Customer.find(params[:id])
    customer.update_attributes!(permitted_params)
    render json: customer.as_json, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { detail: e.message }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { detail: e.message }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit(:reference, :company_name, :address, :telephone, :email, :contact_name, :contact_surname)
  end
end
