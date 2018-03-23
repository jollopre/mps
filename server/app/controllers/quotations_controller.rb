class QuotationsController < ApplicationController
	# POST /quotations with body { "quotation": { "customer_id": number }}
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid (e.g {quotation: {}} since quotation is without quotes)
		begin
			quotation = Quotation.create!(quotation_params)
			head :created, location: quotation_path(quotation)
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
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

	# GET /quotations/:id
	def show
		begin
			quotation = Quotation.find(params[:id])
			render(json: quotation.as_json, status: :ok)
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
		end
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
