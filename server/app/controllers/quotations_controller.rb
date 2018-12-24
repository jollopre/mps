class QuotationsController < ApplicationController
  def create
    required_params = params.require(:quotation).permit(:customer_id)
    quotation = Quotation.create!(required_params)
    head :created, location: quotation_path(quotation)
  end

  def index
    params.require(:customer_id)
    query = Quotation.where({ customer_id: params[:customer_id] })
    meta = { count: query.count, per_page: Kaminari.config.default_per_page }
    quotations = query.page(params[:page] || 1)
    render(json: { meta: meta, data: quotations.as_json }, status: :ok)
  end

  def show
    quotation = Quotation.find(params[:id])
    render(json: quotation.as_json, status: :ok)
  end

  def search
    params.require(:customer_id)
    query = Quotation.search(params[:term]).where(customer_id: params[:customer_id])
    meta = { count: query.count, per_page: Kaminari.config.default_per_page }
    quotations = query.page(params[:page] || 1)
    render(json: { meta: meta, data: quotations.as_json }, status: :ok)
  end
end
