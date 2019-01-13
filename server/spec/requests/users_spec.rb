require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe '/api/sign-in' do
  include_context 'authentication'

  describe '#sign_in' do
    context 'when user is already signed in' do
      let(:password) do
        'secret_password'
      end
      before do
        params = { user: { email: user.email, password: password }}
        post '/api/sign-in', params: params
        user.token = parsed_response['token']
      end

      it 'returns unprocessable entity' do
        post '/api/sign-in', headers: authentication_header

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user param is missing' do
      before do
        post '/api/sign-in'
      end

      it_behaves_like 'bad_request'
    end

    context 'when user.email param is missing' do
      before do
        params = { user: { password: 'secret_password' }}
        post '/api/sign-in', params: params
      end

      it_behaves_like 'bad_request'

      it 'email is missing' do
        error = parsed_response['errors'].first
        expect(error['detail']).to eq('param is missing or the value is empty: email')
      end
    end

    context 'when user.password param is missing' do
      before do
        params = { user: { email: 'someone@somewhere.com' }}
        post '/api/sign-in', params: params
      end

      it_behaves_like 'bad_request'

      it 'email is missing' do
        error = parsed_response['errors'].first
        expect(error['detail']).to eq('param is missing or the value is empty: password')
      end
    end

    context 'when the email is not found' do
      before do
        params = { user: { email: 'unknown@nowhere.com', password: 'wadus' }}
        post '/api/sign-in', params: params
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)

        error = parsed_response['errors'].first
        expect(error['detail']).to eq('email or password not valid')
      end
    end

    context 'when the password is not valid' do
      before do
        params = { user: { email: 'someone@somewhere.com', password: 'invalid' }}
        post '/api/sign-in', params: params
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)

        error = parsed_response['errors'].first
        expect(error['detail']).to eq('email or password not valid')
      end
    end

    context 'when email and password are valid' do
      before do
        params = { user: { email: 'someone@somewhere.com', password: 'secret_password' }}
        post '/api/sign-in', params: params
      end

      it 'returns ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a token' do
        expect(parsed_response['token']).not_to be_nil
      end
    end
  end
end

RSpec.describe '/api/sign-out' do
  include_context 'authentication'
end
