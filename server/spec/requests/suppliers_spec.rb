require 'rails_helper'
require 'requests/shared_context'
require 'requests/shared_examples_for_errors'

RSpec.describe '/api/suppliers' do
  include_context 'authentication'

  describe '#index' do
    before do
      create(:supplier, reference: 'SUP1')
      get '/api/suppliers', headers: authentication_header
    end
    it 'returns ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all the suppliers' do
      expect(parsed_response).to include(hash_including('reference' => 'SUP1'))
    end
  end
end
