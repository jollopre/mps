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
    composed_email = ComposedEmail.find(params[:id])
    composed_email.send_email!
    head(:created)
  rescue ComposedEmail::EmailAlreadyDelivered => e
    errors = ErrorsService.do(OpenStruct.new(errors: [e.message], status: 422))
    render json: errors, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.require(:composed_email).permit(:subject, :body, :enquiry_ids => [], :supplier_ids => [])
  end
end
