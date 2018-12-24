RSpec.shared_context 'authentication' do
  let(:user) do
    create(:someone)
  end
  let(:authentication_header) do
    { 'HTTP_AUTHORIZATION': ActionController::HttpAuthentication::Token.encode_credentials(user.token) }
  end
end
