class EnquiriesController < ApplicationController
  def index
    enquiries = Enquiry
      .includes({ feature_values: :feature })
      .where({ quotation_id: params[:quotation_id] })
    render json: enquiries.as_json(), status: :ok
  end

  def create
    params.require(:enquiry).permit(:quantity, :product_id)
    enquiry = Enquiry.create!({
        quantity: params[:enquiry][:quantity],
        quotation_id: params[:quotation_id],
        product_id: params[:enquiry][:product_id] })
    head :created, location: enquiry_path(enquiry)
  end

  def show
    enquiry = Enquiry
      .includes({ feature_values: :feature })
      .find(params[:id])
    render json: enquiry.as_json, status: :ok
  end

  def update
    permitted = params.require(:enquiry).permit(:quantity, :quantity2, :quantity3)
    enquiry = Enquiry
      .includes({ feature_values: :feature })
      .find(params[:id])
    enquiry.update_attributes!(permitted)
    render json: enquiry.as_json, status: :ok
  end

  def export
    enquiry = Enquiry
      .includes({
      feature_values: {
        feature: [ :feature_label, :feature_options ]
      }}).find(params[:id])
    et = EnquiryTemplate.new(enquiry)
    send_data(et.render, filename: "enquiry_#{params[:id]}.pdf", type: :pdf, status: :ok)
  end

  def destroy
    id = params[:id]
    enquiry = Enquiry.destroy(id)
    render json: { id: enquiry.id }.to_json, status: :ok
  end
end
