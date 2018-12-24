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
        expect(response_detail).to eq('param is missing or the value is empty: composed_email')
      end
    end

    it 'returns bad request when the record is invalid' do
      post composed_emails_path, params: { composed_email: { foo: 'bar' } }, headers: authentication_header
      expect(response).to have_http_status(:bad_request)
      expect(response_detail).to include('Validation failed: Subject can\'t be blank, Body can\'t be blank')
    end

    it 'returns not found when any association does not exist' do
      post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: [-1] }}, headers: authentication_header
      expect(response).to have_http_status(:not_found)
      expect(response_detail).to eq('Couldn\'t find Enquiry with \'id\'=[-1]')
      post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', supplier_ids: [-1] }}, headers: authentication_header
      expect(response).to have_http_status(:not_found)
      expect(response_detail).to eq('Couldn\'t find Supplier with \'id\'=[-1]')
    end

    it 'returns success with location header set' do
      enquiry_ids = [enquiries(:enquiry1).id]
      supplier_ids = [suppliers(:supplier1).id]
      post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: enquiry_ids, supplier_ids: supplier_ids }}, headers: authentication_header
      expect(response).to have_http_status(:created)
      expect(response.location).to include(/([^foo]*)/.match(composed_email_path('foo'))[0])
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
    it 'returns not found when the id does not exist' do
      get composed_email_path(-1), headers: authentication_header
      expect(response).to have_http_status(:not_found)
    end
    it 'returns success with the record' do
      get composed_email_path(composed_emails(:composed_email1)), headers: authentication_header
      expect(response).to have_http_status(:ok)
      expect(response.body).not_to be_empty
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
