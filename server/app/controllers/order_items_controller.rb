class OrderItemsController < ApplicationController
	# GET /orders/:order_id/order_items
	def index
		order_items = OrderItem.includes([
			:product,
			feature_values: [ :feature ]
			]).where({ order_id: params[:order_id] })
		render json: order_items.as_json(), status: :ok
	end

	# POST /orders/:order_id/order_items
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid
		begin
			params.require(:order_item).permit(:quantity, :product_id)
			orderItem = OrderItem.create!({ 
				quantity: params[:order_item][:quantity].nil? ? 1 : params[:order_item][:quantity],
				order_id: params[:order_id],
				product_id: params[:order_item][:product_id] })
			head :created, location: order_item_path(orderItem)
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end

	# GET /order_items/:id
	def show
		begin
			order_item = OrderItem
				.includes({ feature_values: :feature })
				.find(params[:id])
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
			order_item = OrderItem
				.includes({ feature_values: :feature })
				.find(params[:id])
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

	# GET /order_items/:id/export
	def export
		begin
			order_item = OrderItem
				.includes({
					feature_values: {
						feature: [ :feature_label, :feature_options ]
					}})
				.find(params[:id])
			oip = OrderItemPdf.new(order_item)
			send_data(oip.render_pdf, filename: "order_item_#{params[:id]}.pdf", type: :pdf, status: :ok)
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
 		end	
	end
end
