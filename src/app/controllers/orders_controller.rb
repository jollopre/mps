class OrdersController < ApplicationController
	# POST /orders with body { "order": { "customer_id": number }}
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid (e.g {order: {}} since order is without quotes)
		begin
			Order.create!(order_params)
			render body: nil, status: :no_content
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		end
	end

	# GET /orders
	def index
		@orders = Order.all
		render json: @orders.as_json({only: [:id, :created_at, :updated_at]})
	end

	# /orders/:id
	def show
		begin
			order = Order.find(params[:id])
			render json: order.as_json()
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
