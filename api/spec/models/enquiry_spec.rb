require 'rails_helper'

RSpec.describe Enquiry do
  let(:enquiry) do
    build(:enquiry, quantity: 50)
  end

  describe '#as_json' do
    context 'when options are passed' do
      it 'returns a hash' do
        result = enquiry.as_json(only: :quantity) 

        expect(result).to eq({ 'quantity' => 50 })
      end
    end

    context 'when NO options are passed' do
      it 'returns only own properties' do
        result = enquiry.as_json

        expect(result).to include('id', 'quantity', 'quantity2', 'quantity3', 'quotation_id', 'product_id')
      end

      it 'returns feature_values as a hash' do
        result = enquiry.as_json

        expect(result).to include({ 'feature_values' => {}})
      end
    end
  end

  describe '.validates' do
    context 'when quantity is not an integer number' do
      it 'raises ActiveRecord::RecordInvalid' do
        enquiry.quantity = 'wadus'
        enquiry.quantity2 = 'wadus'
        enquiry.quantity3 = 'wadus'

        expect do
          enquiry.validate!
        end.to raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message).to match(/Quantity is not a number/)
          expect(error.message).to match(/Quantity2 is not a number/)
          expect(error.message).to match(/Quantity3 is not a number/)
        end
      end
    end

    context 'when quantity is not >= zero' do
      it 'raises ActiveRecord::RecordInvalid' do
        enquiry.quantity = -1
        enquiry.quantity2 = -1
        enquiry.quantity3 = -1

        expect do
          enquiry.validate!
        end.to raise_error do |error|
          expect(error).to be_a(ActiveRecord::RecordInvalid)
          expect(error.message).to match(/Quantity must be greater than or equal to 0/)
          expect(error.message).to match(/Quantity2 must be greater than or equal to 0/)
          expect(error.message).to match(/Quantity3 must be greater than or equal to 0/) 
        end
      end
    end
  end

  describe '.after_create' do
    it 'creates feature_values for every feature associated to the product' do
      features = [create(:width), create(:no_printed_sides)]
      product = create(:plastic_carrier_bag, features: features)
      quotation = create(:quotation1)
      enquiry = create(:enquiry, product: product, quotation: quotation)

      feature_ids_from_product = enquiry.product.features.map(&:id)
      feature_ids_from_feature_values = enquiry.feature_values.map do |fv|
        fv.feature.id
      end
      expect(feature_ids_from_feature_values).to eq(feature_ids_from_product)
    end
  end
end
