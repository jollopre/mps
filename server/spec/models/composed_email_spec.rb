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

  describe '#send_email' do
    context 'when delivered_at is present' do
      it 'raises RuntimeError' do
        composed_email.delivered_at = Time.now
        expect do
          composed_email.send_email!
        end.to raise_error(RuntimeError, /Email has been already delivered/)
      end
    end

    context 'when delivered_at is NOT present' do
      it "sends email" do
        message_delivery = double(:message_delivery, deliver_now: nil)
        allow(EnquiriesMailer).to receive(:as_attachment).with(composed_email).and_return(message_delivery)

        composed_email.send_email!

        expect(message_delivery).to have_received(:deliver_now)
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
