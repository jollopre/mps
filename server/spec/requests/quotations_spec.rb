require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe '/api/quotations' do
  include_context 'authentication'

  describe '#create' do
    context 'when quotation param is missing' do
      before do
        post '/api/quotations', headers: authentication_header
      end

      it_behaves_like 'bad_request'
    end

    context 'when record is invalid' do
      context 'since customer_id does not exist' do
        before do
          params = { quotation: { customer_id: 'invalid' }}
          post '/api/quotations', params: params, headers: authentication_header
        end

        it_behaves_like 'unprocessable_entity'
      end
    end

    context 'when record is created' do
      before do
        customer = create(:ref1)
        params = { quotation: { customer_id: customer.id }}
        post '/api/quotations', params: params, headers: authentication_header
      end

      it 'returns created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a location header' do
        headers = response.headers
        expect(headers['Location']).to match(/\/api\/quotations\/[0-9]+/)
      end
    end
  end

  describe '#show' do
    context 'when the record is not found' do
      before do
        get '/api/quotations/INVALID', headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is found' do
      let(:quotation) do
        create(:quotation1)
      end
      before do
        get "/api/quotations/#{quotation.id}", headers: authentication_header
      end

      it 'returns ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the quotation' do
        expect(parsed_response).to include('id' => quotation.id)
      end
    end
  end
end
