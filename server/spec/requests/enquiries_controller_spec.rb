require 'rails_helper'

RSpec.describe EnquiriesController do
  let(:someone) { create(:someone) }
  describe '#index' do
    pending
  end

  describe '#create' do
    pending
  end

  describe '#show' do
    pending
  end

  describe '#update' do
    pending
  end

  describe '#export' do
    pending
  end

  describe '#delete' do
    it 'returns 404 when the enquiries does not exist' do
      delete enquiry_path('INVALID'), headers: auth_header(someone)

      expect(response).to have_http_status(:not_found)
    end

    context 'returns 200' do
      it 'when the enquiry has no dependencies' do
        enquiry = create(:enquiry1)
        delete enquiry_path(enquiry), headers: auth_header(someone)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'id' => enquiry.id })
      end

      it 'when the enquiry is referenced in a feature value' do
        enquiry = create(:enquiry1)
        feature = create(:width)
        create(:feature_value, value: '34.5', feature: feature, enquiry: enquiry)

        delete enquiry_path(enquiry), headers: auth_header(someone)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ 'id' => enquiry.id })
      end
    end
  end
end
