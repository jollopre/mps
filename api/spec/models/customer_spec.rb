require 'rails_helper'

RSpec.describe Customer do
  describe '.validates' do
    context 'when email is invalid' do
      it 'raises ActiveRecord::RecordInvalid' do
        customer = build(:customer, email: 'foo@bar.c')
        expect do
          customer.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Email is invalid/)
      end
    end

    context 'when email is valid' do
      it 'does not raise any error' do
        customer = build(:customer, email: 'user@somewhere.com')

        expect do
          customer.validate!
        end.not_to raise_error
      end
    end
  end

  describe '#as_json' do
    let(:customer) do
      build(:customer, email: 'user@somewhere.com')
    end

    context 'when options are passed' do
      it 'returns a hash' do
        result = customer.as_json(only: :email)

        expect(result).to eq({ 'email' => 'user@somewhere.com' })
      end
    end

    context 'when NO options are passed' do
      it 'excludes created_at and updated_at' do
        result = customer.as_json

        expect(result).not_to include('created_at', 'updated_at')
      end
    end
  end

  it 'class respond to class method csv_importer' do
    expect(described_class).to respond_to(:csv_importer).with(1).argument
  end
end
