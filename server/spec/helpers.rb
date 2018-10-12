module Helpers
  def auth_header(user)
    return { 'Authorization' => 'Token token='+user.token }
  end

  def response_detail
    parsed_response.fetch('detail')
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
