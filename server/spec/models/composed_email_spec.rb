require 'rails_helper'
require 'support/as_json_spec'

RSpec.describe ComposedEmail do
  fixtures :composed_emails
  fixtures :enquiries
  fixtures :suppliers

  describe 'validates_presence_of' do
    it 'raises RecordInvalid when subject is not present' do
      composed_email = ComposedEmail.new(body: 'foo')
      expect{
	composed_email.validate!
      }.to raise_error(ActiveRecord::RecordInvalid) do |error|
	  expect(error.message).to include('Subject can\'t be blank')
	end
    end
    it 'raises RecordInvalid when body is not present' do
      composed_email = ComposedEmail.new(subject: 'foo')
        expect{
          composed_email.validate!
	}.to raise_error(ActiveRecord::RecordInvalid) do |error|
	  expect(error.message).to include('Body can\'t be blank')
        end
    end
    it 'raises RecordInvalid when enquiries is not present' do
      composed_email = ComposedEmail.new(body: 'foo', subject: 'bar')
      composed_email.suppliers << suppliers(:supplier1)
      expect do
        composed_email.validate!
      end.to raise_error(ActiveRecord::RecordInvalid) do |error|
        expect(error.message).to include('Enquiries can\'t be blank')
      end
    end
    it 'raises RecordInvalid when suppliers is not present' do
      composed_email = ComposedEmail.new(body: 'foo', subject: 'bar')
      composed_email.enquiries << enquiries(:enquiry1)
      expect do
        composed_email.validate!
      end.to raise_error(ActiveRecord::RecordInvalid) do |error|
        expect(error.message).to include('Suppliers can\'t be blank')
      end
    end

    it 'not raises any error when subject, body, enquiries and suppliers are present' do
      composed_email = ComposedEmail.new(subject: 'foo', body: 'bar')
      enquiry = enquiries(:enquiry1)
      composed_email.enquiries << enquiries(:enquiry1)
      composed_email.suppliers << suppliers(:supplier1)
      expect do
	      composed_email.validate!
      end.to_not raise_error
    end
  end
  describe '#send_email' do
    it 'raises RuntimeError' do
      composed_email = ComposedEmail.new(subject: 'foo', body: 'bar')
      composed_email.delivered_at = Time.now
      composed_email.enquiries << enquiries(:enquiry1)
      composed_email.suppliers << suppliers(:supplier1)
      expect do
        composed_email.send_email!
      end.to raise_error(RuntimeError) do |error|
        expect(error.message).to eq('Email has been already delivered')
      end
    end
    it "sends email" do
      composed_email = ComposedEmail.new(subject: 'foo', body: 'bar')
      composed_email.enquiries << enquiries(:enquiry1)
      composed_email.suppliers << suppliers(:supplier1)
      message_delivery = double(:message_delivery, deliver_now: 'delivers an email')
      allow(EnquiriesMailer).to receive(:as_attachment).with(composed_email).and_return(message_delivery)

      composed_email.send_email!

      expect(message_delivery).to have_received(:deliver_now)
    end
  end
  context 'when no arguments are passed' do
    subject { composed_emails(:composed_email1).as_json() }
    it_behaves_like '#as_json', ['id','subject', 'body', 'attachment', 'delivered_at','enquiry_ids', 'supplier_ids']
  end
  context 'when arguments are passed' do
    subject { composed_emails(:composed_email1).as_json(only: :subject) }
    it_behaves_like '#as_json', ['subject']
  end
end
