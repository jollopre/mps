require 'rails_helper'

RSpec.describe Supplier do
  let(:supplier) do
    build(:supplier, reference: 'SUP1')
  end
  describe '#as_json' do
    context 'when options are passed' do
      it 'returns a hash' do
        result = supplier.as_json(only: :reference)

        expect(result).to eq({ 'reference' => 'SUP1' })
      end
    end

    context 'when NO options are passed' do
      it 'excludes created_at and updated_at' do
        result = supplier.as_json

        expect(result).to eq({
          'id' => nil,
          'reference' => 'SUP1',
          'company_name' => nil,
          'contact' => nil,
          'email' => nil,
          'telephone' => nil
        })
      end
    end
  end
end
