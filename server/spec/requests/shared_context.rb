RSpec.shared_context 'authentication' do
  let(:authentication_header) do
    someone = create(:someone)
    { 'HTTP_AUTHORIZATION': ActionController::HttpAuthentication::Token.encode_credentials(someone.token) }
  end
end
