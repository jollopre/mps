class ComposedEmailsController < ApplicationController
  def create
    composed_email = ComposedEmail.create!(permitted_params)
    head :created, location: composed_email_path(composed_email)
  end

  def update
    composed_email = ComposedEmail.find(params[:id])
    composed_email.update_attributes!(permitted_params)
    render json: composed_email.as_json, status: :ok
  end

  def show
    composed_email = ComposedEmail.find(params[:id])
    render json: composed_email.as_json, status: :ok
  end

  def send_email
    begin
      composed_email = ComposedEmail.find(params[:id])
      composed_email.validate!
      composed_email.send_email!
      head(:created)
    rescue ActiveRecord::RecordNotFound => e
      render json: { detail: e.message }, status: :not_found
    rescue ActiveRecord::RecordInvalid => e
      render json: { detail: e.message }, status: :bad_request
    rescue => e
      render json: { detail: e.message }, status: :bad_request
    end
  end

  private

  def permitted_params
    params.require(:composed_email).permit(:subject, :body, :enquiry_ids => [], :supplier_ids => [])
  end
end
