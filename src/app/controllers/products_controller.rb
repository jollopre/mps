class ProductsController < ApplicationController
	# Returns a JSON Array of Product objects
	# GET /products
	def index
		@products = Product.all
		#render json @products.as_json(only: [:id, :name], include: :features)
	end

	# Returns a JSON object for a product
	# GET /products/:id
	def show
		product = Product.find(params[:id])
		render json: product, include: ['features','features.feature_label','features.feature_options']
	end	
end
