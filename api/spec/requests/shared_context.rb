RSpec.shared_context 'authentication' do
  def authentication_header(token = create(:someone).token)
    { 'HTTP_AUTHORIZATION': ActionController::HttpAuthentication::Token.encode_credentials(token) }
  end
end
