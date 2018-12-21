require 'rails_helper'

RSpec.describe Quotation do
  let(:quotation) do
    build(:quotation, id: 1)
  end
  describe '#as_json' do
    context 'when options are passed' do
      it 'returns a hash' do
        result = quotation.as_json(only: :id)

        expect(result).to eq({ 'id' => 1 })
      end
    end

    context 'when NO options are passed' do
      it 'returns a hash' do
        result = quotation.as_json

        expect(result).to eq({
          'id' => 1,
          'customer_id' => nil,
          'created_at' => nil,
          'updated_at' => nil,
          'enquiry_ids' => []
        })
      end
    end
  end
end
