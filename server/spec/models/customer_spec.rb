require 'rails_helper'
require 'support/as_json_spec'

RSpec.describe Customer do
  fixtures :customers
  context 'when no arguments are passed' do
    subject { customers(:customer1).as_json() }
    it_behaves_like '#as_json', ['address', 'company_name', 'contact_name', 'contact_surname', 'email', 'id', 'reference', 'telephone']
  end

  context 'when arguments are passed' do
    subject { customers(:customer1).as_json(only: :address) }
    it_behaves_like '#as_json', ['address']
  end
end