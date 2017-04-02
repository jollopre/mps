class OrderItemsController < ApplicationController
	# GET /orders/:order_id/order_items
	def index
		order_items = OrderItem.where(order_id: params[:order_id])
		render json: order_items.as_json, status: :ok
	end

	# POST /orders/:order_id/order_items
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid
		# TODO automatic creation of feature_values according to the product_id
		# TODO ensuring quantity value is integer (validation rule in model)
		begin
			order_item_params()
			OrderItem.create!({ quantity: params[:order_item][:quantity],
				order_id: params[:order_id],
				product_id: params[:order_item][:product_id] })
			head :no_content
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end

	# GET /order_items/:id
	def show
		begin
			order_item = OrderItem.find(params[:id])
			render json: order_item.as_json, status: :ok
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
 		end
	end

	# PATCH/PUT /order_items/:id
	def update
		# TODO
		render json: {action: 'update'}, status: :ok
	end

	private
		def order_item_params
			# require raises ParameterMissing if :order_item does not exist
			params.require(:order_item).permit(:quantity, :product_id)
		end
end
