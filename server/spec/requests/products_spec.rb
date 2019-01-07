require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe '/api/products' do
  include_context 'authentication'

  describe '#index' do
    before do
      create(:plastic_carrier_bag)
      get '/api/products', headers: authentication_header
    end

    it 'returns success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all the products stored' do
      expect(parsed_response).to include({ 'name' => 'Plastic Carrier Bag' })
    end
  end

  describe '#show' do
    context 'when the record is not found' do
      before do
        get '/api/products/INVALID', headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is found' do
      before do
        product = create(:product, name: 'A product')
        get "/api/products/#{product.id}", headers: authentication_header
      end

      it 'returns sucess' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the record' do
        expect(parsed_response).to include('name' => 'A product')
      end
    end
  end
end
