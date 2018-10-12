require 'rails_helper'
require 'support/as_json_spec'

RSpec.describe Customer do
  describe '#serializable_hash' do
    it 'returns default serialization' do
      customer = create(:customer, email: 'ref1@somewhere.com')

      result = customer.as_json

      expect(result).to include('reference', 'company_name', 'address', 'telephone', 'email', 'contact_name', 'contact_surname')
    end

    it 'returns serialization according to options passed' do
      customer = create(:customer, email: 'ref1@somewhere.com')

      result = customer.as_json(only: :email)

      expect(result).to eq({ 'email' => 'ref1@somewhere.com' })
    end
  end
end
