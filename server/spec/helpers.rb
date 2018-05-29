module Helpers
  def auth_header(user)
    return { 'Authorization' => 'Token token='+user.token }
  end
  def response_detail
    return ActiveSupport::JSON.decode(response.body).fetch('detail')
  end
end