require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe EnquiriesController do
  include_context 'authentication'

  describe '#index' do
    let(:quotation) do
      create(:quotation1)
    end
    before do
      create(:enquiry1, quotation: quotation)
      create(:enquiry2)
      get "/api/quotations/#{quotation.id}/enquiries", headers: authentication_header
    end

    it 'returns success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the enquiries for a quotation' do
      expect(parsed_response).to all(include({ 'quotation_id' => quotation.id }))
    end
  end

  describe '#create' do
    context 'when enquiry param is missing' do
      before do
        post '/api/quotations/a_quotation/enquiries', headers: authentication_header
      end

      it_behaves_like 'bad_request'
    end

    context 'when an invalid quotation is passed' do
      before do
        product = create(:plastic_carrier_bag)
        post '/api/quotations/INVALID/enquiries', params: { enquiry: { quantity: 1, product_id: product.id }}, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when an invalid product is passed' do
      before do
        quotation = create(:quotation1)
        post "/api/quotations/#{quotation.id}/enquiries", params: { enquiry: { quantity: 1, product_id: 'invalid' }}, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when an invalid quantity is passed' do
      before do
        quotation = create(:quotation1)
        product = create(:plastic_carrier_bag)
        post "/api/quotations/#{quotation.id}/enquiries", params: { enquiry: { quantity: -1, product_id: product.id }}, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when the creation succeed' do
      before do
        quotation = create(:quotation1)
        product = create(:plastic_carrier_bag)
        post "/api/quotations/#{quotation.id}/enquiries", params: { enquiry: { quantity: 100, product_id: product.id }}, headers: authentication_header
      end

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the location for the resource created' do
        expect(response.headers['Location']).to match(/\/api\/enquiries\/[0-9]+/)
      end
    end
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

    context 'when the record is found' do
      before do
        enquiry = create(:enquiry1)
        get "/api/enquiries/#{enquiry.id}/export", headers: authentication_header
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns pdf content' do
        headers = response.headers
        expect(headers['Content-Type']).to eq('application/pdf')
        expect(headers['Content-Disposition']).to match(/attachment; filename=\"enquiry_[0-9]+.pdf\"/)
      end
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
