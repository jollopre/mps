require 'rails_helper'

RSpec.describe ComposedEmail do
  let(:composed_email) do
    build(:composed_email)
  end

  describe '.validates' do
    context 'when subject is not present' do
      it 'raises ActiveRecord::RecordInvalid' do
        composed_email.subject = nil

        expect do
          composed_email.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Subject can't be blank/)
      end
    end

    context 'when email is not present' do
      it 'raises ActiveRecord::RecordInvalid' do
        composed_email.body = nil

        expect do
          composed_email.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Body can't be blank/)
      end
    end

    context 'when enquiries are not present' do
      it 'raises ActiveRecord::RecordInvalid' do
        composed_email.enquiries = []

        expect do 
          composed_email.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Enquiries can't be blank/)
      end
    end

    context 'when suppliers are not present' do
      it 'raises ActiveRecord::RecordInvalid' do
        composed_email.suppliers = []

        expect do 
          composed_email.validate!
        end.to raise_error(ActiveRecord::RecordInvalid, /Suppliers can't be blank/)
      end
    end
  end

  describe '#deliver!' do
    context 'when delivered_at is present' do
      it 'raises RuntimeError' do
        composed_email.delivered_at = Time.now
        expect do
          composed_email.deliver!
        end.to raise_error(described_class::EmailAlreadyDelivered, /Email has been already delivered/)
      end
    end

    context 'when delivered_at is NOT present' do
      let(:composed_email) do
        enquiry_ids = [create(:enquiry1).id]
        supplier_ids = [create(:supplier).id]
        create(:composed_email, enquiry_ids: enquiry_ids, supplier_ids: supplier_ids)
      end
      let(:now) do
        Time.new(2018,12,31,10,30,00)
      end

      context 'when block is passed' do
        it 'yields to it' do
          expect do |b|
            composed_email.deliver!(&b)
          end.to yield_with_no_args
        end
      end

      it 'updates delivered_at to now' do
        allow(Time).to receive(:now).and_return(now)
        allow(composed_email).to receive(:update_column)

        composed_email.deliver!

        expect(composed_email).to have_received(:update_column).with(:delivered_at, now)
      end
    end
  end

  describe '#as_json' do
    context 'when options are passed' do
      it 'returns a hash' do
        result = composed_email.as_json(only: :subject)

        expect(result).to eq({ 'subject' => 'a_subject' })
      end
    end

    context 'when NO options are passed' do
      it 'excludes created_at and updated_at' do
        result = composed_email.as_json

        expect(result).not_to include('created_at', 'updated_at')
      end

      it 'includes enquiry_ids and supplier_ids' do
        result = composed_email.as_json

        expect(result).to include('enquiry_ids', 'supplier_ids')
      end
    end
  end
end
