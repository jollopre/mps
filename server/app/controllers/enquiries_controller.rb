class EnquiriesController < ApplicationController
	# GET /quotations/:quotation_id/enquiries
	def index
		enquiries = Enquiry
			.includes({ feature_values: :feature })
			.where({ quotation_id: params[:quotation_id] })
		render json: enquiries.as_json(), status: :ok
	end

	# POST /quotations/:quotation_id/enquiries
	def create
		# TODO ActionDispatch::ParamsParser for when JSON is invalid
		begin
			params.require(:enquiry).permit(:quantity, :product_id)
			orderItem = Enquiry.create!({ 
				quantity: params[:enquiry][:quantity].nil? ? 1 : params[:enquiry][:quantity],
				quotation_id: params[:quotation_id],
				product_id: params[:enquiry][:product_id] })
			head :created, location: enquiry_path(orderItem)
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end

	# GET /enquiries/:id
	def show
		begin
			enquiry = Enquiry
				.includes({ feature_values: :feature })
				.find(params[:id])
			render json: enquiry.as_json, status: :ok
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
 		end
	end

	# PATCH/PUT /enquiries/:id
	def update
		# TODO ActionDispatch::ParamsParser for when JSON is invalid
		begin
			permitted = params.require(:enquiry).permit(:quantity)
			enquiry = Enquiry
				.includes({ feature_values: :feature })
				.find(params[:id])
			enquiry.update_attributes!(permitted)
			render json: enquiry.as_json, status: :ok
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
		rescue ActiveRecord::RecordInvalid => e
			render json: { detail: e.message }, status: :bad_request
		end
	end

	# GET /enquiries/:id/export
	def export
		begin
			enquiry = Enquiry
				.includes({
					feature_values: {
						feature: [ :feature_label, :feature_options ]
					}})
				.find(params[:id])
			oip = EnquiryPdf.new(enquiry)
			send_data(oip.render_pdf, filename: "enquiry_#{params[:id]}.pdf", type: :pdf, status: :ok)
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: e.message }, status: :not_found
 		end	
	end
end
