class QuotationsController < ApplicationController
  def create
    quotation = Quotation.create!(quotation_params)
    head :created, location: quotation_path(quotation)
  end

  # GET /quotations?customer_id=foo&page=bar
  def index
    begin
      params.require(:customer_id)
      query = Quotation.where({ customer_id: params[:customer_id] })
      meta = { count: query.count, per_page: Kaminari.config.default_per_page }
      quotations = query.page(params[:page] || 1)
      render(json: { meta: meta, data: quotations.as_json }, status: :ok)
    rescue ActionController::ParameterMissing => e
      render json: { detail: e.message }, status: :bad_request 
    end
  end

  def show
    quotation = Quotation.find(params[:id])
    render(json: quotation.as_json, status: :ok)
  end

  # GET /quotations/search/:term?customer_id=foo&page=bar
  def search
    begin
      params.require(:customer_id)
      query = Quotation.search(params[:term]).where(customer_id: params[:customer_id])
      meta = { count: query.count, per_page: Kaminari.config.default_per_page }
      quotations = query.page(params[:page] || 1)
      render(json: { meta: meta, data: quotations.as_json }, status: :ok)
    rescue ActionController::ParameterMissing => e
      render json: { detail: e.message }, status: :bad_request 
    end
  end

  private
  def quotation_params
    # require raises ParameterMissing if :quotation or quotation[:customer_id] do not exist
    params.require(:quotation).permit(:customer_id).tap do |quotation_params|
      quotation_params.require(:customer_id)
    end
  end
end
