require 'rails_helper'

RSpec.describe Customers::CSVImporter do
  let(:described_class) do
    Class.new.extend(Customers::CSVImporter)
  end

  describe '.csv_importer' do
    context 'when the path_file exists' do
      it 'inserts COMP1 into the db table' do
        described_class.csv_importer("spec/assets/customers.csv")

        customer = Customer.find_by_reference('COMP1')
        expect(customer.company_name).to eq('COMPANY 1')
        expect(customer.reference).to eq('COMP1')
        expect(customer.address).to eq('High Street')
        expect(customer.telephone).to eq('999333666')
        expect(customer.email).to eq('user@company1.com')
        expect(customer.city).to eq('Glasgow')
        expect(customer.postcode).to eq('G1 1PL')
        expect(customer.country).to eq('United Kingdom (GB)')
      end

      it 'inserts default email for COMP2' do
        described_class.csv_importer("spec/assets/customers.csv")

        customer = Customer.find_by_reference('COMP2')

        expect(customer.email).to eq('noone@nowhere.com')
      end

      it 'logs email is not valid for COMP2' do
        logger = double(:logger, debug: true)
        allow(Logger).to receive(:new).and_return(logger)

        described_class.csv_importer("spec/assets/customers.csv")

        expect(logger).to have_received(:debug).with(/email:  invalid for customer reference: COMP2/).at_least(:once)
      end
    end
  end
end
