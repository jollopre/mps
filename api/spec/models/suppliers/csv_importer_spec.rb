require 'rails_helper'

RSpec.describe Suppliers::CSVImporter do
  let(:described_class) do
    Class.new.extend(Suppliers::CSVImporter)
  end

  describe '.csv_importer' do
    it 'inserts COMP1 into the db table' do
      described_class.csv_importer('spec/assets/suppliers.csv')

      supplier = Supplier.find_by_reference('COMP1')
      expect(supplier.reference).to eq('COMP1')
      expect(supplier.company_name).to eq('COMPANY 1')
      expect(supplier.contact).to eq('')
      expect(supplier.email).to eq('user@company1.com')
      expect(supplier.telephone).to eq('999333666')
      expect(supplier.address).to eq('High Street')
      expect(supplier.city).to eq('Glasgow')
      expect(supplier.postcode).to eq('G1 1PL')
      expect(supplier.country).to eq('United Kingdom (GB)')
    end

    context 'when email is missing' do
      it 'does not insert COMP2 because missing email' do
        described_class.csv_importer('spec/assets/suppliers.csv')

        supplier = Supplier.find_by_reference('COMP2')

        expect(supplier).to be_nil
      end

      it 'logs the validation errors for an invalid record' do
        logger = double(:logger, debug: true)
        allow(Logger).to receive(:new).and_return(logger)

        described_class.csv_importer('spec/assets/suppliers.csv')
        
        expect(logger).to have_received(:debug).with(/for supplier reference: COMP2/)
      end
    end
  end
end
