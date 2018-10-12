require 'rails_helper'

RSpec.describe CustomersController do
  let(:someone) { create(:someone) }
  let(:customer) { build(:customer, reference: 'REF1', email: 'ref1@somewhere.com') }

  describe '#index' do
    it 'returns 200 status' do
      customer.save!

      get customers_path, headers: auth_header(someone)

      expect(response).to have_http_status(:ok)
    end

    it 'body contains meta and data properties' do
      customer.save!

      get customers_path, headers: auth_header(someone)

      expect(parsed_response).to include('meta', 'data')
    end

    it 'body meta contains count and per_page' do
      customer.save!

      get customers_path, headers: auth_header(someone)

      expect(parsed_response['meta']).to include('count', 'per_page' => 10)
    end

    it 'body data is not empty' do
      customer.save!

      get customers_path, headers: auth_header(someone)

      expect(parsed_response['data']).not_to be_empty
    end
  end

  describe '#show' do
    it 'returns 404 status' do
      get customer_path('INVALID'), headers: auth_header(someone)

      expect(response).to have_http_status(404)
    end

    it 'returns 200 status' do
      customer.save!

      get customer_path(customer.id), headers: auth_header(someone)

      expect(response).to have_http_status(200)
    end

    it 'returns customer object' do
      customer.save!

      get customer_path(customer.id), headers: auth_header(someone)

      expect(parsed_response).to include('reference', 'company_name', 'email')
    end
  end

  describe '#search' do
    it 'returns 200 status' do
      customer.save!

      get '/api/customers/search/ref1', headers: auth_header(someone)

      expect(response).to have_http_status(200)
    end

    it 'body contains meta and data properties' do
      customer.save!

      get '/api/customers/search/ref1', headers: auth_header(someone)

      expect(parsed_response).to include('meta', 'data')
    end

    it 'body meta contains count and per_page' do
      customer.save!

      get '/api/customers/search/ref1', headers: auth_header(someone)

      expect(parsed_response['meta']).to include('count', 'per_page' => 10)
    end

    it 'body data is not empty' do
      customer.save!

      get '/api/customers/search/ref1', headers: auth_header(someone)

      expect(parsed_response['data']).not_to be_empty
    end

    it 'body data is empty' do
      customer.save!

      get '/api/customers/search/non-matching-term', headers: auth_header(someone)

      expect(parsed_response['data']).to be_empty
    end
  end

  describe '#update' do
    it 'returns 404 status' do
      put customer_path('INVALID'), headers: auth_header(someone)

      expect(response).to have_http_status(404)
    end

    it 'returns 422 when email is invalid' do
      customer.save!
      params = { email: 'invalid_email' }

      put customer_path(customer.id), params: params, headers: auth_header(someone)

      expect(response).to have_http_status(422)
      expect(response_detail).to include('Email is invalid')
    end

    context 'when no errors' do
      it 'returns 200 status' do
        customer.save!
        params = { email: 'ref1_updated@somewhere.com' }

        put customer_path(customer.id), params: params, headers: auth_header(someone)

        expect(response).to have_http_status(200)
      end

      it 'returns the updated object' do
        customer.save!
        params = { email: 'ref1_updated@somewhere.com', foo: 'bar' }

        put customer_path(customer.id), params: params, headers: auth_header(someone)

        expect(parsed_response).to include('email' => 'ref1_updated@somewhere.com')
        expect(parsed_response).to include('reference', 'company_name', 'address', 'telephone', 'contact_name', 'contact_surname')
      end
    end
  end
end
