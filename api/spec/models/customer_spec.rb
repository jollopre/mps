require 'rails_helper'

RSpec.describe Customer do
  describe '.validates_format_of' do
    context 'when email does not match the regex' do
      it 'raises ActiveRecord::RecordInvalid' do
        customers = [
          build(:customer, email: nil),
          build(:customer, email: ''),
          build(:customer, email: '@somewhere.com'),
          build(:customer, email: 'a@'),
          build(:customer, email: 'a@.com'),
          build(:customer, email: 'a@somewhere'),
          build(:customer, email: 'a@somewhere.'),
          build(:customer, email: 'a@somewhere.com.'),
          build(:customer, email: 'a@somewhere.a')
        ]
        customers.each do |customer|
          expect do
            customer.validate!
          end.to raise_error(ActiveRecord::RecordInvalid, /Email is invalid/)
        end
      end
    end

    context 'when email matches the regex' do
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
