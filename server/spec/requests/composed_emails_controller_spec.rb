require 'rails_helper'
require 'requests/shared_context'

RSpec.describe '/api/composed_emails', type: :request do
  include_context 'authentication'
  fixtures :composed_emails
  fixtures :enquiries, :suppliers

  describe '#create' do
    context 'when a parameter is missing' do
      it 'returns bad_request' do
        post '/api/composed_emails', headers: authentication_header

        expect(response).to have_http_status(:bad_request)
        expect(parsed_response['errors']).to all(include('status' => 400))
      end
    end

    context 'when the record is invalid' do
      it 'returns a unprocessable_entity' do
        post '/api/composed_emails', params: { composed_email: { foo: 'bar' } }, headers: authentication_header

        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['errors']).to all(include('status' => 422))
      end
    end

    context 'when the record is not found' do
      it 'returns not found when enquiry does not exist' do
        post '/api/composed_emails', params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: [-1] }}, headers: authentication_header
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors']).to all(include('status' => 404))
      end

      it 'returns not found when supplier does not exist' do
        post '/api/composed_emails', params: { composed_email: { subject: 'foo', body: 'bar', supplier_ids: [-1] }}, headers: authentication_header

        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors']).to all(include('status' => 404))
      end
    end

    context 'when the record is created' do
      let(:enquiry_ids) do
        [create(:enquiry1).id]
      end
      let(:supplier_ids) do
        [create(:supplier).id]
      end

      it 'returns created status' do
        post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: enquiry_ids, supplier_ids: supplier_ids }}, headers: authentication_header
        expect(response).to have_http_status(:created)
      end

      it 'returns header location' do
        post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: enquiry_ids, supplier_ids: supplier_ids }}, headers: authentication_header

        expect(response.location).to match(/\/api\/composed_emails\/[0-9]+/)
      end
    end
  end

  describe '#update' do
    let(:composed_email) { composed_emails(:composed_email1) }
    it 'returns bad request when any parameter is missing' do
      put composed_email_path(composed_email.id), headers: authentication_header
      expect(response).to have_http_status(:bad_request)
      expect(response_detail).to eq('param is missing or the value is empty: composed_email')
    end
    it 'returns bad request when the record is invalid' do
      put composed_email_path(composed_email.id), params: { composed_email: { subject: '', body: '' } }, headers: authentication_header
      expect(response).to have_http_status(:bad_request)
      expect(response_detail).to eq('Validation failed: Subject can\'t be blank, Body can\'t be blank')
    end
    it 'returns not found when any association does not exist' do
      put composed_email_path(composed_email.id), params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: [-1] }}, headers: authentication_header
      expect(response).to have_http_status(:not_found)
      expect(response_detail).to eq('Couldn\'t find Enquiry with \'id\'=[-1]')
      put composed_email_path(composed_email.id), params: { composed_email: { subject: 'foo', body: 'bar', supplier_ids: [-1] }}, headers: authentication_header
      expect(response).to have_http_status(:not_found)
      expect(response_detail).to eq('Couldn\'t find Supplier with \'id\'=[-1]')
    end
  end

  describe '#show' do
    context 'when the record is not found' do
      it 'returns not_found' do
        get '/api/composed_emails/-1', headers: authentication_header
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors']).to all(include('status' => 404))
      end
    end

    context 'when the record is found' do
      let(:composed_email_id) do
        enquiry_ids = [create(:enquiry1).id]
        supplier_ids = [create(:supplier).id]
        create(:composed_email, enquiry_ids: enquiry_ids, supplier_ids: supplier_ids).id
      end

      it 'returns success' do
        get "/api/composed_emails/#{composed_email_id}", headers: authentication_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns the record' do
        get "/api/composed_emails/#{composed_email_id}", headers: authentication_header

        expect(parsed_response['id']).to eq(composed_email_id)
      end
    end
  end

  describe '#send_email' do
    it 'returns bad request when there are no enquiries associated' do
      composed_email = composed_emails(:composed_email1)
      composed_email.enquiries.destroy_all
      post send_email_composed_email_path(composed_email), headers: authentication_header
      expect(response).to have_http_status(:bad_request)
      expect(response_detail).to include('Enquiries can\'t be blank')
    end
    it 'returns bad request when there are no supplier associated' do
      composed_email = composed_emails(:composed_email1)
      composed_email.suppliers.destroy_all
      post send_email_composed_email_path(composed_email), headers: authentication_header
      expect(response).to have_http_status(:bad_request)
      expect(response_detail).to include('Suppliers can\'t be blank')
    end
    it 'returns bad request when attempting to send the email after deliverated_at set' do
      composed_email = composed_emails(:composed_email1)
      composed_email.delivered_at = Time.now
      composed_email.save!
      post send_email_composed_email_path(composed_email), headers: authentication_header
      expect(response).to have_http_status(:bad_request)
      expect(response_detail).to eq('Email has been already delivered')
    end
    it 'returns success otherwise' do
      post send_email_composed_email_path(composed_emails(:composed_email1)), headers: authentication_header
      expect(response).to have_http_status(:created)
      expect(response.body).to be_empty
    end
  end
end
