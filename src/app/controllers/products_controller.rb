class ProductsController < ApplicationController
	# Returns a JSON Array of Product objects
	# GET /products
	def index
		@products = Product.all
		render json: @products.as_json({only: [:id, :name]}), status: :ok
	end

	# Returns a JSON object for a product
	# GET /products/:id
	def show
		begin
			product = Product.find(params[:id])
			render json: product.as_json()
		rescue ActiveRecord::RecordNotFound => e
			render json: {
				detail: e.message
			}.to_json, status: :not_found
		end
	end
	# http://jsonapi.org/ specification	
end