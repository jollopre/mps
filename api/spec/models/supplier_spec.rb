require 'rails_helper'

RSpec.describe Supplier do
  let(:supplier) do
    build(:supplier, reference: 'SUP1')
  end

  describe '.validates' do
    context 'when email is invalid' do
      it 'raises ActiveRecord::RecordInvalid' do
        supplier = build(:supplier, email: 'foo@bar.c')
        expect do
          supplier.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Email is invalid/)
      end
    end

    context 'when email is valid' do
      it 'does not raise any error' do
        supplier = build(:supplier, email: 'user@somewhere.com')

        expect do
          supplier.validate!
        end.not_to raise_error
      end
    end
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
          'email' => 'someone@somewhere.com',
          'telephone' => nil,
          'address' => nil,
          'city' => nil,
          'postcode' => nil,
          'country' => nil
        })
      end
    end
  end

  it 'class respond to class method csv_importer' do
    expect(described_class).to respond_to(:csv_importer).with(1).argument
  end
end
