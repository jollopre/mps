class OrderItemsController < ApplicationController
	# GET /orders/:order_id/order_items
	def index
		order_items = OrderItem.includes(:product)
						.where(order_id: params[:order_id])
		render json: order_items.as_json({ only: [:id, :quantity],
						include: {
							product: { only: [:id, :name]}
						}
					}), status: :ok
	end

	# POST /orders/:order_id/order_items
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid
		begin
			params.require(:order_item).permit(:quantity, :product_id)
			OrderItem.create!({ 
				quantity: params[:order_item][:quantity].nil? ? 1 : params[:order_item][:quantity],
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
		# TODO ActionDispatch::ParamsParser for when JSON is invalid
		begin
			permitted = params.require(:order_item).permit(:quantity)
			order_item = OrderItem.find(params[:id])
			order_item.update_attributes!(permitted)
			render json: order_item.as_json, status: :ok
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end
end
