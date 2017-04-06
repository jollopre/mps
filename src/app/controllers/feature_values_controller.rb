class FeatureValuesController < ApplicationController
	# PATCH/PUT /feature_values/:id
	def update
		begin
			permitted = params.require(:feature_value).permit(:value)
			feature_value = FeatureValue.find(params[:id])
			feature_value.update_attributes!(permitted)
			render json: feature_value.as_json, status: :ok
		rescue ActionController::ParameterMissing => e
			render json: {detail: e.message}, status: :bad_request
		rescue ActiveRecord::RecordNotFound => e
			render json: {detail: e.message}, status: :not_found
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end
end
