class FeatureValuesController < ApplicationController
  def update
    permitted = params.require(:feature_value).permit(:value)
    feature_value = FeatureValue.includes({
      feature: [:feature_options]
    }).find(params[:id])
    feature_value.update_attributes!(permitted)
    render json: feature_value.as_json, status: :ok
  end
end
