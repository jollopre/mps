require 'rails_helper'

RSpec.describe Product do
  let(:product) do
    build(:product, name: 'a_product_name')
  end
  describe '#as_json' do
    context 'when options are passed' do
      it 'returns a hash' do
        result = product.as_json(only: :name)

        expect(result).to eq({ 'name' => 'a_product_name' })
      end
    end

    context 'when NO options are passed' do
      it 'includes id, name and hash of features' do
        result = product.as_json

        expect(result).to eq({ 'id' => nil, 'name' => 'a_product_name', 'features' => {}})
      end
    end
  end
end
