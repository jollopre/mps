class OrdersController < ApplicationController

	# POST /orders
	def create
		begin
			customer = Customer.find(params[:order][:customer_id])
			@order = Order.new({customer: customer})
			begin
				@order.save!
				render json: {}.to_json, status: :no_content
			rescue ActiveRecord::RecordNotSaved => e
				render json: {
					detail: e.message
				}.to_json, status: :internal_server_error
			end
		rescue ActiveRecord::RecordNotFound => e
			render json: {
				detail: e.message
			}.to_json, status: :not_found
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
			render json: {
				detail: e.message
			}.to_json, status: :not_found
		end
	end
end
