require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe EnquiriesController do
  include_context 'authentication'

  describe '#index' do
    it 'returns success' do
      pending
    end

    it 'returns the enquiries for a quotation' do
      pending
    end
  end

  describe '#create' do
    pending
  end

  describe '#show' do
    context 'when the record is not found' do
      before do
        get '/api/enquiries/INVALID', headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is found' do
      before do
        enquiry = create(:enquiry1, id: 12345, quantity: 500)
        get "/api/enquiries/#{enquiry.id}", headers: authentication_header
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the record 12345' do
        expect(parsed_response).to include('id' => 12345, 'quantity' => 500)
      end
    end
  end

  describe '#update' do
    context 'when enquiry param is missing' do
      before do
        enquiry = create(:enquiry1)
        params = {}
        put "/api/enquiries/#{enquiry.id}", params: params, headers: authentication_header
      end

      it_behaves_like 'bad_request'
    end

    context 'when the record is invalid' do
      before do
        enquiry = create(:enquiry1)
        params = { enquiry: { quantity: 'wadus' }}
        put "/api/enquiries/#{enquiry.id}", params: params, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when the record is not found' do
      before do
        params = { enquiry: { quantity: 5 }}
        put '/api/enquiries/INVALID', params: params, headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is updated' do
      before do
        enquiry = create(:enquiry1)
        params = { enquiry: { quantity: 5 }}
        put "/api/enquiries/#{enquiry.id}", params: params, headers: authentication_header
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated enquiry' do
        expect(parsed_response).to include('quantity' => 5)
      end
    end
  end

  describe '#export' do
    context 'when the record is not found' do
      before do
        get '/api/enquiries/INVALID/export', headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    it 'returns success' do
      pending
    end

    it 'returns pdf content' do
      pending
    end
  end

  describe '#delete' do
    context 'when record is not found' do
      before do
        delete '/api/enquiries/INVALID', headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record has no dependencies' do
      it 'returns success' do
        enquiry = create(:enquiry1)
        delete "/api/enquiries/#{enquiry.id}", headers: authentication_header

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'id' => enquiry.id })
      end
    end

    context 'when the record has dependencies' do
      it 'returns success' do
        enquiry = create(:enquiry1)
        feature = create(:width)
        create(:feature_value, value: '34.5', feature: feature, enquiry: enquiry)

        delete "/api/enquiries/#{enquiry.id}", headers: authentication_header

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'id' => enquiry.id })
      end
    end
  end
end
