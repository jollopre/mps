class OrdersController < ApplicationController
	# POST /orders with body { "order": { "customer_id": number }}
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid (e.g {order: {}} since order is without quotes)
		begin
			order = Order.create!(order_params)
			head :created, location: order_path(order)
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end

	# GET /orders?customer_id=foo&page=bar
	def index
		if params[:customer_id].present?
			query = Order.where({ customer_id: params[:customer_id] })
			meta = { count: query.count, per_page: Kaminari.config.default_per_page }
			orders = query.page(params[:page] || 1)
			render(json: { meta: meta, data: orders.as_json }, status: :ok)
		else
			render(json: { detail: 'Mising parameter customer_id' }, status: :bad_request)
		end
	end

	# GET /orders/:id
	def show
		begin
			order = Order.find(params[:id])
			render(json: order.as_json, status: :ok)
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
		end
	end
	private
		def order_params
			# require raises ParameterMissing if :order does not exist
			params.require(:order).permit(:customer_id)
		end
end
