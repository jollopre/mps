require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe CustomersController do
  include_context 'authentication'

  let!(:customer) { create(:customer, reference: 'REF1', email: 'ref1@somewhere.com') }

  describe '#index' do
    it 'returns 200 status' do
      get customers_path, headers: authentication_header

      expect(response).to have_http_status(:ok)
    end

    it 'body contains meta and data properties' do
      get customers_path, headers: authentication_header

      expect(parsed_response).to include('meta', 'data')
    end

    it 'body meta contains count and per_page' do
      get customers_path, headers: authentication_header

      expect(parsed_response['meta']).to include('count', 'per_page' => 10)
    end

    it 'body data is not empty' do
      get customers_path, headers: authentication_header

      expect(parsed_response['data']).not_to be_empty
    end
  end

  describe '#show' do
    context 'when the record is not found' do
      before do
        get customer_path('INVALID'), headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    it 'returns 200 status' do
      get customer_path(customer.id), headers: authentication_header

      expect(response).to have_http_status(200)
    end

    it 'returns customer object' do
      get customer_path(customer.id), headers: authentication_header

      expect(parsed_response).to include('reference', 'company_name', 'email')
    end
  end

  describe '#search' do
    it 'returns 200 status' do
      get '/api/customers/search/ref1', headers: authentication_header

      expect(response).to have_http_status(200)
    end

    it 'body contains meta and data properties' do
      get '/api/customers/search/ref1', headers: authentication_header

      expect(parsed_response).to include('meta', 'data')
    end

    it 'body meta contains count and per_page' do
      get '/api/customers/search/ref1', headers: authentication_header

      expect(parsed_response['meta']).to include('count', 'per_page' => 10)
    end

    it 'body data is not empty' do
      get '/api/customers/search/ref1', headers: authentication_header

      expect(parsed_response['data']).not_to be_empty
    end

    it 'body data is empty' do
      get '/api/customers/search/non-matching-term', headers: authentication_header

      expect(parsed_response['data']).to be_empty
    end
  end

  describe '#update' do
    context 'when the record is not found' do
      before do
        put customer_path('INVALID'), headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is invalid' do
      before do
        params = { email: 'invalid_email' }
        put customer_path(customer.id), params: params, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when no errors' do
      it 'returns 200 status' do
        params = { email: 'ref1_updated@somewhere.com' }

        put customer_path(customer.id), params: params, headers: authentication_header

        expect(response).to have_http_status(200)
      end

      it 'returns the updated object' do
        params = { email: 'ref1_updated@somewhere.com', foo: 'bar' }

        put customer_path(customer.id), params: params, headers: authentication_header

        expect(parsed_response).to include('email' => 'ref1_updated@somewhere.com')
        expect(parsed_response).to include('reference', 'company_name', 'address', 'telephone', 'contact_name', 'contact_surname')
      end
    end
  end
end
