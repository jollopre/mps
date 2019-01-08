class SuppliersController < ApplicationController
  def index
    suppliers = Supplier.all
    render json: suppliers.as_json, status: :ok
  end
end
