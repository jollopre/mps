require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe '/api/composed_emails', type: :request do
  include_context 'authentication'

  describe '#create' do
    context 'when a parameter is missing' do
      before do
        post '/api/composed_emails', headers: authentication_header
      end

      it_behaves_like 'bad_request'
    end

    context 'when the record is invalid' do
      before do
        post '/api/composed_emails', params: { composed_email: { foo: 'bar' } }, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when the record is not found' do
      context 'since enquiry_ids are non-existent' do
        before do
          post '/api/composed_emails', params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: [-1] }}, headers: authentication_header
        end

        it_behaves_like 'not_found'
      end

      context 'since supplier_ids are non-existent' do
        before do
          post '/api/composed_emails', params: { composed_email: { subject: 'foo', body: 'bar', supplier_ids: [-1] }}, headers: authentication_header
        end

        it_behaves_like 'not_found'
      end
    end

    context 'when the record is created' do
      let(:enquiry_ids) do
        [create(:enquiry1).id]
      end
      let(:supplier_ids) do
        [create(:supplier).id]
      end

      it 'returns created status' do
        post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: enquiry_ids, supplier_ids: supplier_ids }}, headers: authentication_header
        expect(response).to have_http_status(:created)
      end

      it 'returns header location' do
        post composed_emails_path, params: { composed_email: { subject: 'foo', body: 'bar', enquiry_ids: enquiry_ids, supplier_ids: supplier_ids }}, headers: authentication_header

        expect(response.location).to match(/\/api\/composed_emails\/[0-9]+/)
      end
    end
  end

  describe '#update' do
    let(:composed_email_id) do
      enquiry_ids = [create(:enquiry1).id]
      supplier_ids = [create(:supplier).id]
      create(:composed_email, enquiry_ids: enquiry_ids, supplier_ids: supplier_ids).id
    end

    context 'when a parameter is missing' do
      before do
        put "/api/composed_emails/#{composed_email_id}", headers: authentication_header
      end

      it_behaves_like 'bad_request'
    end

    context 'when the record is invalid' do
      before do
        put "/api/composed_emails/#{composed_email_id}", params: { composed_email: { subject: '', body: '' } }, headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when the record is not found' do
      context 'since enquiry_ids are non-existent' do
        before do
          put "/api/composed_emails/#{composed_email_id}", params: { composed_email: { enquiry_ids: [-1] }}, headers: authentication_header
        end

        it_behaves_like 'not_found'
      end

      context 'since supplier_ids are non-existent' do
        before do
          put "/api/composed_emails/#{composed_email_id}", params: { composed_email: { supplier_ids: [-1] }}, headers: authentication_header
        end

        it_behaves_like 'not_found'
      end
    end

    context 'when the record is found' do
      it 'returns success' do
        put "/api/composed_emails/#{composed_email_id}", params: { composed_email: { subject: 'foo' }}, headers: authentication_header

        expect(response).to have_http_status(:ok)
      end

      it 'updates it' do
        put "/api/composed_emails/#{composed_email_id}", params: { composed_email: { subject: 'foo' }}, headers: authentication_header

        composed_email = ComposedEmail.find(composed_email_id)
        expect(composed_email.subject).to eq('foo')
      end
    end
  end

  describe '#show' do
    context 'when the record is not found' do
      before do
        get '/api/composed_emails/-1', headers: authentication_header
      end

      it_behaves_like 'not_found'
    end

    context 'when the record is found' do
      let(:composed_email_id) do
        enquiry_ids = [create(:enquiry1).id]
        supplier_ids = [create(:supplier).id]
        create(:composed_email, enquiry_ids: enquiry_ids, supplier_ids: supplier_ids).id
      end

      it 'returns success' do
        get "/api/composed_emails/#{composed_email_id}", headers: authentication_header

        expect(response).to have_http_status(:ok)
      end

      it 'returns the record' do
        get "/api/composed_emails/#{composed_email_id}", headers: authentication_header

        expect(parsed_response['id']).to eq(composed_email_id)
      end
    end
  end

  describe '#send_email' do
    let(:composed_email) do
      enquiry_ids = [create(:enquiry1).id]
      supplier_ids = [create(:supplier, email: 'user@somewhere.com').id]
      create(:composed_email, enquiry_ids: enquiry_ids, supplier_ids: supplier_ids)
    end

    context 'when the email has been delivered' do
      before do
        composed_email.delivered_at = Time.now
        composed_email.save!
        post "/api/composed_emails/#{composed_email.id}/send_email", headers: authentication_header
      end

      it_behaves_like 'unprocessable_entity'
    end

    context 'when the email has not been delivered yet' do
      before do
        allow(EnquiriesMailer).to receive(:do).and_return(message_delivery)
      end
      let(:message_delivery) do
        double(:message_delivery, deliver_now: nil)
      end

      it 'returns success' do
        post "/api/composed_emails/#{composed_email.id}/send_email", headers: authentication_header

        expect(response).to have_http_status(:created)
        expect(response.body).to be_empty
      end

      it 'an EnquiriesMailer is actioned' do
        post "/api/composed_emails/#{composed_email.id}/send_email", headers: authentication_header

        expect(EnquiriesMailer).to have_received(:do).with(composed_email: composed_email, current_user: instance_of(User))
      end

      it 'the email gets sent' do
        allow(message_delivery).to receive(:deliver_now)

        post "/api/composed_emails/#{composed_email.id}/send_email", headers: authentication_header

        expect(message_delivery).to have_received(:deliver_now)
      end
    end
  end
end
