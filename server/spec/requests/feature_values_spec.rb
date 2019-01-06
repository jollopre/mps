require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe '/api/feature_values' do
  include_context 'authentication'

  describe '#update' do
    context 'when feature_value param is missing' do
      before do
        put '/api/feature_values/an_id', headers: authentication_header
      end

      it_behaves_like 'bad_request'
    end

    context 'when record is not found' do
      before do
        params = { feature_value: { value: 'a_value' }}
        put '/api/feature_values/INVALID', params: params, headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is invalid' do
      let(:integer_feature_value) do
        feature = create(:no_printed_sides)
        enquiry = create(:enquiry1, product: feature.product)
        enquiry.feature_values.find do |fv|
          fv.feature.id == feature.id
        end
      end

      before do
        params = { feature_value: { value: 'wadus' }}
        put "/api/feature_values/#{integer_feature_value.id}", params: params, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when the record is updated' do
      let(:integer_feature_value) do
        feature = create(:no_printed_sides)
        enquiry = create(:enquiry1, product: feature.product)
        enquiry.feature_values.find do |fv|
          fv.feature.id == feature.id
        end
      end

      before do
        params = { feature_value: { value: 2 }}
        put "/api/feature_values/#{integer_feature_value.id}", params: params, headers: authentication_header
      end

      it 'returns success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated feature_value' do
        expect(parsed_response).to include({ 'id' => integer_feature_value.id, 'value' => 2 })
      end
    end
  end
end
